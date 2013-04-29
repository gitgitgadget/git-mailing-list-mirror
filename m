From: Yann Hodique <yann.hodique@gmail.com>
Subject: Re: consistency problem on ZFS
Date: Mon, 29 Apr 2013 19:16:54 +0100
Message-ID: <m2d2td6w2x.fsf@jarvis.hodique.info>
References: <m2bo8yxyg2.fsf@jarvis.hodique.info>
	<7vk3nmpcgn.fsf@alter.siamese.dyndns.org>
	<m2haip6x1z.fsf@jarvis.hodique.info>
	<7v61z5jjvx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 20:18:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWseb-0000L0-4c
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758372Ab3D2SSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:18:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:49047 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931Ab3D2SSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:18:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UWseS-0000E4-KX
	for git@vger.kernel.org; Mon, 29 Apr 2013 20:18:12 +0200
Received: from cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com ([86.27.183.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:18:12 +0200
Received: from yann.hodique by cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:18:12 +0200
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
Cancel-Lock: sha1:QbIXCimZvmlaASUHZJoRtxjTikI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222837>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

> Yann Hodique <yann.hodique@gmail.com> writes:
>>>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Yann Hodique <yann.hodique@gmail.com> writes:
>>>> $ git checkout next; git diff-files; git checkout next; git diff-files
>>>> Already on 'next'
>>>> :100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M	magit.el
>>>> Already on 'next'
>>>> $
>> 
>>> If you run "git update-index --refresh" between the first "checkout"
>>> and "diff-files", do you still see the issue?
>> 
>> Yes, although *way* less often. I just ran a quick experiment and have
>> seen the issue 2 times in 2500 tries.

> Hmph, that indicates somebody other than you or your Git is mucking
> with the inodes of your working tree files and perphas affecting
> ctime on them (we do not pay attention to atime because dirtying
> cached information due to somebody else reading from the file makes
> absolutely no sense, but we do notice ctime changes).  Perhaps
> background virus scanner or something silly like that?

Not that I know of. I certainly don't have any virus scanner, and I even
deactivated spotlight.
In any case, I can't think of anything that would affect that volume
while leaving my HFS+ ones alone, except for zfs background
processes themselves.

Yann.

-- 
What senses do we lack that we cannot see or hear another world all around us?

  -- The Orange Catholic Bible
