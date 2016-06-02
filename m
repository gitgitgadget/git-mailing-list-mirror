From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (May 2016, #09; Tue, 31) t1308 broken
Date: Thu, 2 Jun 2016 16:01:36 +0200
Message-ID: <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 16:01:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8TC7-0007qt-3k
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 16:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbcFBOBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 10:01:50 -0400
Received: from mout.web.de ([212.227.15.4]:62701 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbcFBOBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 10:01:50 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MBTD4-1bIsnA2UiM-00AX9n; Thu, 02 Jun 2016 16:01:42
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:OOgND6ZSgGDMLYLrwYWWocCFUqzKnMbcGBoiVxdbOzUhaBn71GC
 Phq6GI1sN8fi7+Oo+Jz8gA72ZcSdt5yMIdwhb4qKZ4ElwBKoheVo0GX+HvBBTv4pdX9Oocr
 Biy7MBNCGrHxyNxrjiIjazvnYj0l83eBSNr7EP+g4lcQgBAyFU9N7AVntDdnTHcUlVADYxB
 iO0soTtV8V2tMQYhpPNnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EYvDSp89vn0=:KHgW/eysLE/EzqFoPyTNGI
 o+J8hHKP3w+GbnmHgmsl6pce+eY86YqxdWSH0hbg+oHf0lxhi6UeTNPotZgQYw2HGKmSZEJOd
 A+7LJXqrxfThJNWvBo2PrUE6o4IcswKTzxIeIj0BxW7mugXihNyTstk59W1/ZAlNF42OeLZp8
 5fUHdH7uipWlerwQqjCEbRHWOq+gyquUw1i+4Fji66uLv0GFYMku4mHfvKHW9Tfetehwckk/F
 +8n8xMT1eA3zktu0Vd04Jj/eQ9J+WzhDth5WsuDkxMKSpQYa3iwM243c8/oFz+SgRBCEv45qp
 7ayYLeyOQ8ii8J2gHHtYeL33AmQHM8gv5tH3m+5gEfvmigE0dcLphiYRWXgv27QPtHjInksZG
 li840Xa+qAudhkBAVPxHQSmi9bsprhzZqG68PLnm25tSgWJJ3ZKgswV0t9/UM9ZtbmupoK5+V
 cKE1J5stAw1N9HjUDCgcA9RHB/Gov0t1D60aE/iGtGV8O3iXGtYxPARs92olZFBK7dW54tGvE
 RZSldGOyNnwo8FRPLm9wGkkNqTZ5DgEGLUFwpkNca4Xbk9hkbpauh05VsVYnbOVuUJafCMIUf
 QghqvxJCrSxRQ/3mcZV3jgw32sXFDr6+3U0taVgR98vIVudF1Z4RBjZDxkBbB+II391wpFjCz
 jRGirr47znStdeefO2EM+YR0As6KSHZ3fUCPAv+SXG2ISiMR1CorgnmaJtPIdFeBgse+cAd2e
 QLQ+1Rq7li5S/VbxJSVuAavEZlPnhfi8y7Wrv9M2anaDhC7m1FddTEkxVs5rsHEXmJ0g6BlI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296199>

It seams as  ./t1308-config-set.sh is broken,
when the the directory is a soft link:

-name=/home/tb/NoBackup/projects/git/git.pu/t/trash
directory.t1308-config-set/.gitconfig
+name=/home/tb/projects/git/git.pu/t/trash directory.t1308-config-set/.gitconfig
 scope=global

 key=foo.bar
not ok 28 - iteration shows correct origins

I havent't digged further, too many conflicts in the config code, may be
somebody knows it directly ?
