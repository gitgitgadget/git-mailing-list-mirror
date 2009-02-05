From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: How to use git-fmt-merge-msg?
Date: Thu, 5 Feb 2009 13:25:32 +0000
Message-ID: <B22C0229-47F4-48EC-9C68-63696C7BB3F2@manchester.ac.uk>
References: <84B3CCAA-A044-4517-B2C8-14D5DD754FD2@manchester.ac.uk> <adf1fd3d0902050459s4fcb914ai2b9c8c04e9f72b02@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV4G0-0007hW-6e
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbZBENZi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 08:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbZBENZg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 08:25:36 -0500
Received: from tranquility.mcc.ac.uk ([130.88.200.145]:55217 "EHLO
	tranquility.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859AbZBENZf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 08:25:35 -0500
Received: from kelvin.its.manchester.ac.uk ([130.88.25.195])
	by tranquility.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1LV4EX-000Mzg-Bc; Thu, 05 Feb 2009 13:25:33 +0000
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:57664)
	by kelvin.its.manchester.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1LV4EX-0003KE-4J; Thu, 05 Feb 2009 13:25:33 +0000
In-Reply-To: <adf1fd3d0902050459s4fcb914ai2b9c8c04e9f72b02@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:57664
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108558>


On 5 Feb 2009, at 12:59, Santi B=E9jar wrote:

> 2009/2/5 Robert Haines <rhaines@manchester.ac.uk>:
>> Hi all,
>>
>> I would like to use git-fmt-merge-msg to produce automatic =20
>> summaries of what
>> commits are being merged when I merge one branch into the other - =20
>> like I see
>> all the time in git.git, etc. The problem I am having is that I can =
=20
>> only
>> seem to get it to work with remote branches via .git/FETCH_HEAD - =20
>> basically
>> I don't know what else I can feed it to do what I want.
>>
>> Say I have a local repo with no remotes so no .git/FETCH_HEAD. Can =20
>> I use
>> git-fmt-merge-msg to produce such a summary when I'm just merging =20
>> local
>> branches? I've tried feeding just about everything I can find =20
>> in .git/ into
>> it but with no luck. Is there anything generated during the merge =20
>> that can
>> be used as input if I do a merge --no-commit? A list of merged =20
>> commits or
>> something?
>>
>> I'm sure I've missed something simple here...
>
> Sure :-)
>
> Manpage of git merge:
>       --log
>           In addition to branch names, populate the log message with =
=20
> one-line
>           descriptions from the actual commits that are being merged.
>
> Manpage of git config:
>       merge.log
>           Whether to include summaries of merged commits in newly =20
> created
>           merge commit messages. False by default.

Aaaahhhh.... Time for me to upgrade. The version of git I am using =20
(1.5.3.8) doesn't have merge --log. No wonder I couldn't find it!

Thanks for the pointer and sorry for the noise...

Cheers,
Rob
