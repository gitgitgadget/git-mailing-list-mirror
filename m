From: Kevin Ballard <kevin@sb.org>
Subject: Re: rebase converts merge commits
Date: Tue, 12 Oct 2010 13:27:06 -0700
Message-ID: <523A21BF-F6A1-4BF2-8385-941B61BA769F@sb.org>
References: <AANLkTikz0yUv9+EcT-kVwniUf9xnRe=_y96euNb=stzP@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?S=E9bastien_Barth=E9lemy?= <barthelemy@crans.org>
X-From: git-owner@vger.kernel.org Tue Oct 12 22:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5lRM-0003Aj-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 22:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758008Ab0JLU1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 16:27:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42882 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab0JLU1J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 16:27:09 -0400
Received: by pvc7 with SMTP id 7so237536pvc.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 13:27:09 -0700 (PDT)
Received: by 10.142.133.21 with SMTP id g21mr524184wfd.163.1286915229155;
        Tue, 12 Oct 2010 13:27:09 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e36sm6194163wfj.14.2010.10.12.13.27.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 13:27:07 -0700 (PDT)
In-Reply-To: <AANLkTikz0yUv9+EcT-kVwniUf9xnRe=_y96euNb=stzP@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158876>

On Oct 12, 2010, at 7:55 AM, S=E9bastien Barth=E9lemy wrote:

> By the way, if there is a way to do what I want, please tell me.

Your history is short enough that if you can't get rebase to do what yo=
u want, you could always do it by hand. Create a temp branch to work on=
 based on the bad commit, cherry-pick the good commit with --no-commit,=
 then amend the bad commit. Then just cherry-pick each subsequent commi=
t until you get to the merge. Re-perform the merge. Then just continue =
to cherry-pick subsequent commits. It's not ideal, but it should work.

-Kevin Ballard