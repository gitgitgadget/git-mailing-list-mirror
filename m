From: Bill Lear <rael@zopyra.com>
Subject: Re: Using the --track option when creating a branch
Date: Wed, 29 Oct 2008 14:33:30 -0600
Message-ID: <18696.51354.329776.550395@lisa.zopyra.com>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	<adf1fd3d0810290925s493cdc6oc7534904c864db28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Santi B=?iso-8859-1?B?6Q==?=jar" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 21:34:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHkc-0000Fh-7I
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYJ2Udf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 16:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbYJ2Udf
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:33:35 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60400 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbYJ2Ude convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2008 16:33:34 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m9TKXV708499;
	Wed, 29 Oct 2008 14:33:31 -0600
In-Reply-To: <adf1fd3d0810290925s493cdc6oc7534904c864db28@mail.gmail.com>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99411>

On Wednesday, October 29, 2008 at 17:25:37 (+0100) Santi B=E9jar writes=
:
>On Wed, Oct 29, 2008 at 4:23 PM, Bill Lear <rael@zopyra.com> wrote:
>> We have had a few "crossed stream" problems when developers are
>> working on a local branch and they do an unguarded git push/pull,
>> when they really intended to do git push/pull origin branchname.
>>
>> We use git in a way that makes it desirable for us to only push/pull
>> to the same remote branch.  So, if I'm in branch X, I want 'git push=
'
>> to push to origin/X, and 'git pull' to fetch into origin/X and then
>> merge into X from origin/X.
>>
>> In other words, we want git push/pull to behave in branches other th=
an
>> master the same way it does when in master.
>>
>> I have discovered the '--track' option when creating a local branch,
>> and this appears to me to be the thing that gives us the desired
>> behavior.
>
>branch.autosetupmerge controls if --track is used by default (it is
>true by default since a long time)
>(See "git help config" for details)

Ah, problem solved then.  I'll just have everyone upgrade to the
latest git.  Thanks very much, Santi.


Bill
