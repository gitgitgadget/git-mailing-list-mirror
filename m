From: David Kastrup <dak@gnu.org>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 02 Feb 2014 12:42:52 +0100
Message-ID: <87wqhdzqo3.fsf@fencepost.gnu.org>
References: <87a9e92424.fsf@fencepost.gnu.org>
	<CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
	<8761ox2240.fsf@fencepost.gnu.org>
	<20140202113141.GB29976@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 02 12:43:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9vSP-0006mg-EN
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbaBBLmz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 06:42:55 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:57089 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbaBBLmy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Feb 2014 06:42:54 -0500
Received: from localhost ([127.0.0.1]:56130 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W9vRt-0002C1-9Z; Sun, 02 Feb 2014 06:42:53 -0500
Received: by lola (Postfix, from userid 1000)
	id C2C45DF68C; Sun,  2 Feb 2014 12:42:52 +0100 (CET)
In-Reply-To: <20140202113141.GB29976@serenity.lan> (John Keeping's message of
	"Sun, 2 Feb 2014 11:31:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241365>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Feb 02, 2014 at 12:19:43PM +0100, David Kastrup wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>=20
>> > The file is for past commits only.
>>=20
>> > New commits can contain these info in their messages.
>>=20
>> If it's not forgotten.  Experience shows that things like issue numb=
ers
>> have a tendency to be omitted, and then they stay missing.
>>=20
>> At any rate, this is exactly the kind of stuff that tags are useful =
for,
>> except that using them for all that would render the "tag space"
>> overcrowded.
>
> Actually, I would say this is exactly the sort of thing notes are for=
=2E
>
> git.git uses them to map commits back to mailing list discussions:

But that's the wrong direction.  What is needed in the Emacs case is
mapping the Bazaar reference numbers (and bug numbers) to commits.

While it is true that the history rewriting approach would not deliver
this either (short of git log --grep with suitable patterns), I=A0was
looking for something less of a crutch here.

> Notes aren't fetch by default, but it's not hard for those interested
> to add a remote.*.fetch line to their config.

If we are talking about measures everybody has to actively take before
getting access to functionality, this does not cross the convenience
threshold making it a solution preferred over others.  But it's probabl=
y
feasible to configure a fetch line doing this that will get cloned when
first cloning a repository.  That's not too hot for people with existin=
g
repositories, but since we are talking about a migration from Bazaar
anyway, Git users currently are so by choice and so might be more
willing to update their configuration if it helps with avoiding a fully
new clone.

--=20
David Kastrup
