From: Andreas Ericsson <exon@op5.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 14:40:30 +0200
Message-ID: <49D360BE.6030100@op5.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D35616.1812.DA02BA@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D34015.9080709@op5.com> <49D37190.23422.145597D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <exon@op5.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 14:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lozlg-0000Kf-7Q
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282AbZDAMkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756549AbZDAMkg
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:40:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:1100 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZDAMkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:40:36 -0400
Received: by fg-out-1718.google.com with SMTP id 16so673822fgg.17
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:40:33 -0700 (PDT)
Received: by 10.86.33.10 with SMTP id g10mr6045399fgg.44.1238589633333;
        Wed, 01 Apr 2009 05:40:33 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id d6sm1583058fga.17.2009.04.01.05.40.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:40:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49D37190.23422.145597D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115378>

Ulrich Windl wrote:
> On 1 Apr 2009 at 12:21, Andreas Ericsson wrote:
> 
> [...]
>>> What I don't understand here is: Why wouldn't the $Id$ be updated upon upgrade? 
>>> Because it's a manual process?
>>>
>> It MAY not get updated, since $Id$ tags are per-file instead of per-project.
>> Any sane project will have more than one file, and the file listing the
>> $Id$ that the end-user sees may not have changed since the last release.
>>
>> Per-file revision tags are stupid and useless for anything but a one-file
>> project.
> 
> Hmm...:
> # what vmunix
> vmunix:
>          ivt.s $Date: 2008/11/21 09:10:19 $Revision: r11.31/5 PATCH_11.31 (B11.3
> 1.0903LR)
>          side_dumpdev - HP IDE Dump Driver B.11.31 /ux/core/kern/em/svc/dump/scs
> i_ide_dumpdev.c: Jan  8 2009, 23:48:25
>          eschgr - Changer Driver B.11.31.01 /ux/core/kern/common/io/escsi/eschgr
> /eschgr.c:Jan 10 2007,17:04:47
>          eschgr - Changer Driver B.11.31.01 /ux/core/kern/common/io/escsi/eschgr
> /eschgr_diag.c:Dec 27 2006,16:59:17
> [...]
>         vxfs:$RCSfile: vx_portal.c,v $  $Revision: 4.14.26.3 $
>         vxfs:$RCSfile: vx_portal_osrel.c,v $    $Revision: 1.1.2.1 $
>         vxfs:$RCSfile: vx_portal_dlkm.c,v $     $Revision: 1.1.2.1 $
>         vxfs:$RCSfile: vxportal50.modmeta,v $   $Revision: 1.1.2.5 $
>          wsio_cdio.c $Date: 2008/06/03 05:52:50 $Revision: r11.31/13 PATCH_11.31
>  (B11.31.0809LR)
>          $Revision: wsio:    B11.31.0809LR
>          $Revision: wxb_hp:    B.11.31_LR
>          tracer.s $Date: 2008/04/28 17:14:06 $Revision: r11.31/3 PATCH_11.31 (B1
> 1.31.0809LR)
> 
> For a kernel, where development is decentralized, it would make sense: Imageine a 
> user (or distributor) will nut upgrade anything to the latest version, but only 
> parts (subsystems). Then the single kernel version number is meaningless.
> 

Not really. They can (and should) create their own version numbers. I can't make
sense of the above output. If you ask a developer to piece together the puzzle
that makes up this subsystem and then fit it into the bigger picture, he won't
love you for it. Not only because this particular subsystem might well be the
same version across several different releases with all their different API's
(the input system has changed its API's incompatibly quite frequently over the
last six months, fe, so a driver-version *alone* in that system makes absolutely
no sense if you're trying to debug it).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
