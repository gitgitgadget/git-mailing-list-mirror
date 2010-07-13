From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH] Use dev_t for device id (st_dev) from stat in  setup_git_directory_gently()
Date: Tue, 13 Jul 2010 17:31:06 +0530
Message-ID: <87d3ur7fr1.fsf@hariville.hurrynot.org>
References: <1279011720-21424-1-git-send-email-harinath@hurrynot.org>
	<AANLkTiku82MylNMUX6P8be3xSLVg8g8aYsNWodaOM6LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 14:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYelg-0008Q5-3n
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 14:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab0GMMjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 08:39:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:35105 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab0GMMjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 08:39:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OYelW-0008MT-EN
	for git@vger.kernel.org; Tue, 13 Jul 2010 14:39:14 +0200
Received: from 117.192.154.99 ([117.192.154.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 14:39:14 +0200
Received: from harinath by 117.192.154.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 14:39:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.154.99
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:BAULcBJFBKj6iWcqwuM8yhypeR8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150900>

Hi,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 13, 2010 at 09:02, Raja R Harinath <harinath@hurrynot.org=
> wrote:
>> The original declaration was int, which seems to cause trouble on my
>> machine.
>
> What OS/architecture is your machine running?

Nothing fancy

  $ uname -a
  Linux hariville.hurrynot.org 2.6.35-rc3-00397-g123f94f #146 SMP PREEM=
PT Mon Jul 5 15:50:47 IST 2010 x86_64 GNU/Linux

  $ df .
  Filesystem           1K-blocks      Used Available Use% Mounted on
  /dev/sda1            959314384 389150456 521433560  43% /

- Hari
