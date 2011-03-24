From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: GSOC proposal
Date: Thu, 24 Mar 2011 23:01:04 +0100
Message-ID: <20110324220104.GA18721@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 22:49:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2sPP-0005rl-G4
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 22:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933706Ab1CXVt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 17:49:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53529 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243Ab1CXVt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 17:49:28 -0400
Received: by fxm17 with SMTP id 17so472923fxm.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:subject:message-id
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=uYuc2WRdgLfl2QsGb2YvsqGXGvHTNjaBbZjSS/77jcY=;
        b=tthVCT1LVSy3kSrTw4vhzMg/eEktrsdnekfXTDk/CPOs8TBd13pi8ZEZkzcouxvc1V
         QBNaiybr/BkdFhm+hf7tS76GcMoQz5F8Q1cIsDHQVVQPxm+oVnr2mjXdN6BDhqc8MQnX
         rz9ELedS0XlbgCd87iITBk3s7kyr9G2Xvy/YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=sWGZAGd1TQz7Qya0lnB1y7CZrp8myGBPzT9Id9UFEp49g8lDa+aeBIY+ua8xPw4837
         fWwLs7LzIEFIQrY0AqmWNARp/DLvcqm8O87W2r7NgUhgQRVKiA0TS1yvr6Fsk3oKt4d7
         5ixOEoXFY1AHpt110NqoR8H+UtTGaz+ZeRbz0=
Received: by 10.223.21.18 with SMTP id h18mr11555fab.42.1301003365868;
        Thu, 24 Mar 2011 14:49:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id 21sm149316fav.41.2011.03.24.14.49.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 14:49:25 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Q2saW-000525-H2
	for git@vger.kernel.org; Thu, 24 Mar 2011 23:01:04 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169947>

Hi,
I'm interested in working as a student for git in the GSOC program this
year.

I'm running a lot of web projects with heavy use of git submodules (eac=
h
project has around 40 submodules) and therefore I'm very interested in
enchant the git submodule experience.

I'm asking for your oppinions and id=E9es for my planned todolist for t=
his
summer (if I get accepted of course).

=3D=3D Preventing false "pointers" =3D=3D
It's far too easy to push a gitrepo pointing to a submodule version tha=
t
is not existing on the server. Prevent this by checking for available
submodule versions before acceptingt the push.

=3D=3D Threat every module alike =3D=3D
When failing fetching a submodule, continue fetching the next one
instead of dying. There's no need to prevent fetching a submodule
beginning at 'z' just because a failing in fetching a submodule
beginning at 'a'. The submodules should not be alphabetically dependant
as they are now.

=3D=3D Make submodule changes globally visible =3D=3D
Give git-log submodule support. A git log of showing a new version of a
module should (if choosen by --submodules or alike) also list the
changes to that submodule since the last version of the submodule was
commited.

=3D=3D Move submodules into core =3D=3D
This last bit is excellent described in the link below.

So, what do you all think? Is it too much? Too little? Is the quests
relevant to git?

See also
https://git.wiki.kernel.org/index.php/SoC2011Ideas#Git_Submodules_Enhan=
cements

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
