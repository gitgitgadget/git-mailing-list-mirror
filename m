From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 10:12:28 -0400
Message-ID: <CACPiFCKbfgSZMnpc6Q_Lg6n5YMHQ2bad-bwQsyASk0eMuiAFTQ@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 15:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9zo2-0007Wa-ET
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 15:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759865Ab2CTOMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 10:12:52 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34721 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2CTOMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 10:12:51 -0400
Received: by wibhq7 with SMTP id hq7so111254wib.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=W+rQuDLbUNiuD93ZNpD/kXTHNa3sUaGWdtNvxCEknFo=;
        b=FLah9UYOlAp8jPGmipn/gv2mgKrdZuQzcu5mY4S+/9o/bGzPAShsTe3+gvtl6oSoUO
         Bl1OXqbkt5/F6/xfQXzIgn+H/2nSZxgbu3mXiDoNc4RSklNYbSVrAjtkVxL8woMBZHx2
         h/e2B9FV0LTBCaqpmNrv/41IV8HJKklxpnp4xG0vIi36Tg9NiOMZ+BtyXa4ufTzMRVDi
         LXmwDTIaq0bjd36YxX4+fO3Mj4QDFUJvqHVAouqaZ3rDm/ltcVJkVOp1PduxCPMj1Q7R
         r0iROqEauSqBZiWu+ZNVELo13h5EsD+HAr/gawlReQy4386KPRZPBTch4mTVGHk32HD4
         3fIA==
Received: by 10.50.179.102 with SMTP id df6mr8803281igc.69.1332252770039; Tue,
 20 Mar 2012 07:12:50 -0700 (PDT)
Received: by 10.42.239.131 with HTTP; Tue, 20 Mar 2012 07:12:28 -0700 (PDT)
In-Reply-To: <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193512>

On Sat, Mar 17, 2012 at 1:22 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> If the conclusion of the discussion is that we will change the defaul=
t,
> the transition to the new default will go like this:

I am in general agreement with the course of action outlined. There is
one little thing I had expected in addition, that is not discussed:

 --force should change behaviour, immediately, to "current" or even
none (forcing the user to name the remote and branch explicitly).

The potential for messups with --force combined with "matching" and a
repo that allows it is considerable. And I cannot imagine any
mainstream use cases for --force defaulting to matching; at least none
important enough to counterbalance the damage.

cheers,


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
