From: Yann Hodique <yann.hodique@gmail.com>
Subject: Re: consistency problem on ZFS
Date: Sun, 28 Apr 2013 21:21:07 +0100
Message-ID: <m2zjwiwgng.fsf@jarvis.hodique.info>
References: <m2bo8yxyg2.fsf@jarvis.hodique.info>
	<CAEBDL5W8E_i3V1ePWkf0Ep2iTjY59abqU7Q2w4o0iA8=P_4Onw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 28 22:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWY8z-0005YV-1Y
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 22:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab3D1UYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 16:24:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:33906 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756316Ab3D1UYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 16:24:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UWY8n-0005Pb-0x
	for git@vger.kernel.org; Sun, 28 Apr 2013 22:24:09 +0200
Received: from cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com ([86.27.183.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:24:09 +0200
Received: from yann.hodique by cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:24:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (darwin)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAACpQTFRF
 HBgXPyYdPSkeMiwmRkJBYT4sik8zZF1XqWpMx2RDk42MzYRYtrGw09DVySZyaAAAAklJREFUOMuF
 0z9v00AUAPCHr/kANgowOi6hjFbOCImp1CdF6kaUCwEmkBJSdYmUSBZRGRMsske1MlKIFKVr5XAr
 U1TPSFX6XXjvnKp2KOLG97v3x3dnuP7Hgv/B+vLyLlivZkGwSP6GlXABvHmyDese0GIn2zBzNYCX
 bEGagOswycG6ewMsyMEVVTJMiyQHv2lzuTOSNrDPWfhF8FSpuGXt5IB6s6bCNfLOt8FoEMT1JAv7
 wFz25E7gtqFLqS856IJhl481/MyN27tnGe+wc1uprzn4fvS+MFYxwvDtLcyT1Y9oUhyri3ZHtTIg
 B7NP0WmDMo7VcJABKRvRtKNbq3hxC21ZKx2pMAWVgQt5H95MNSynKnMfZTzTQkSwjKLpPAN1H+CB
 zogmYaa5ED7eUzMeY+tw9HqRAcEBnoUhxYfFQZIBelRNhGjSKj6cb14kBH3hY5dCGI+XpzXTebzJ
 gY+CC47FHiGENQdXVfeBuvA55y5eYRgOnTJRdXC+6eFTiiHbHyplKVGoHGDQw1okzi5BCcUbXANn
 KL4WYAeyZJomJu0l4ALKZvlCvkrBOaG3dhOvdtlLjJt6AP2UN3DosoppOhr20v+Cwq4ncE8JwaLB
 gJpyPa/n0mQIJn0m0EExTHE5HgxUHAvnsjT41ARTnu8juAaUML5bSQHn8vkLBGYDUCkLS+tD577H
 qwjcpl8Le+BmIWgnHkrgws5BCvjTMbpaAsHPcK6+jXNhLfqGQND4XHhn4Ik5T8HCzKu+Bk98qwq+
 6AFOimPZ8Aem5xXrk2gG/wAAAABJRU5ErkJggg==
Cancel-Lock: sha1:/MRCP1ikmgBc4NIQFV5DnfGRh+A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222754>

>>>>> "John" == John Szakmeister <john@szakmeister.net> writes:

> On Sun, Apr 28, 2013 at 3:11 PM, Yann Hodique <yann.hodique@gmail.com> wrote:
>> Hi,
>> 
>> I have a weird problem that seems to manifest itself only on ZFS
>> (actually the Zevo distribution, on OSX). With git 1.8.2.1 by the way.
>> I just switched to ZFS, so I can't blame that particular version of git.
>> 
>> "Sometimes" (I'd say something like 10-15% of the time, fairly
>> reproducible anyway), "git diff-files" will see changes that don't exist
>> for some time, then will catch up with the actual state of the file:
>> 
>> $ git checkout next; git diff-files; git checkout next; git diff-files
>> Already on 'next'
>> :100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M      magit.el
>> Already on 'next'
>> $

> Since you're running with Mac OS X, can I ask what version?  Have you
> seen this with the regular file system (HFS) at all?  It might be that
> you need to disable core.trustctime.

Sure, it's OS X 10.8.3
And no, I don't see this on HFS+ at all. I've just tried numerous times
without success.

And setting core.trustctime seems to do the trick indeed. Many thanks,
that's helping a lot in the short term !

Yann.

-- 
At the age of fifteen, he had already learned silence.

  -- from "A Child's History of Muad'Dib" by the Princess Irulan
