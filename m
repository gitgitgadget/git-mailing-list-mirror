From: Adam Megacz <adam@megacz.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR  invocation?
Date: Mon, 04 Jan 2010 21:08:20 +0000
Organization: Myself
Message-ID: <xuu2zl4tfuij.fsf@nowhere.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 22:09:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRuAf-0004Wm-E0
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 22:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab0ADVIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921Ab0ADVIq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 16:08:46 -0500
Received: from lo.gmane.org ([80.91.229.12]:41204 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab0ADVIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 16:08:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NRuAN-0004Pw-Ss
	for git@vger.kernel.org; Mon, 04 Jan 2010 22:08:43 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 22:08:43 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 22:08:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:0B2OCtm8i9mr/GNaKXTtSj5acZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136143>


Sverre Rabbelier <srabbelier@gmail.com> writes:
> On Sun, Jan 3, 2010 at 18:32, Adam Megacz <adam@megacz.com> wrote:
>> =A0 =A0 I've been having problems lately with running git on machine=
s where
>> =A0 =A0 I forgot to set up my .gitconfig; I wind up with patches tha=
t have
>> =A0 =A0 committers like root@mymachine and so forth. =A0Being automa=
tically
>> =A0 =A0 shown the committer/author when I make the commit would help=
 me
>> =A0 =A0 avoid these situations.
>
> At the very least it should be easy to include these fields as
> comments in the message template.

That would be great.

> But of course you would still be bitten if you used "git commit -m"
> :(.

Perhaps a preference (off by default) demanding that they be set
explicitly when "git commit -m" is used?

Some people care more than others about the metadata; this is for the
folks to whom it matters a lot.

  - a
