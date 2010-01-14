From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 14:44:10 +0100
Message-ID: <46a038f91001140544u64dd7eefn94625cdc40881cd6@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 14:44:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVPzu-0003ce-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 14:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab0ANNoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 08:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755420Ab0ANNoX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 08:44:23 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:35245 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab0ANNoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 08:44:22 -0500
Received: by ewy1 with SMTP id 1so44572ewy.28
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 05:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AIj7anAqMB8xL/SMyAmFCKLPAiB8f0RfgwlvHDMydvA=;
        b=ni+aikXBU9oyuelhIdULnjkiGxiBIFuC6PvWmReu+GhvpOI8O1/MekwKXbtHMl94pu
         EfjUWpw0amEkt3d/UukPtvKT6zBBwrOLgNgDGfMexWozZz25BpbxREBtm4wvle7TLAhv
         G0VVQy/PQfcfaKm2gLlZVcNCArqgFRP312LdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Qo6X+l0bdQr2v6OeDgQ0pa+ZlRaViB4N19rYx9jp/dqMFbh0dBqvr6VbEYLae01xE8
         Ftobmr4n1IH0o7iAIoMxnLSFB+N//XDLJ/+e4OED0exa7Smwq8m0VA2VjNNsYlS9pQ4g
         z0yZbFKKmBc89jnHV1Y1Ch+ADsA+M5Oq+5eZ0=
Received: by 10.213.110.14 with SMTP id l14mr2539475ebp.82.1263476650804; Thu, 
	14 Jan 2010 05:44:10 -0800 (PST)
In-Reply-To: <871vht7cs2.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136992>

On Thu, Jan 14, 2010 at 1:25 AM, Miles Bader <miles@gnu.org> wrote:
> Yay!!

Yay too!

>> git push --track origin mybranch:mybranch
>
> Does it default to the current branch so you can just say "git push --track origin"?

<wishlist>Can we take this further and say

 git push --make-a-new-repo-and-track-it --shared
git+ssh://foo.bar/var/git/mynewthing.git master:master

...?

</wishlist>

Of course it'd only work if you have full ssh access, unless the git
server learns a new command to mkdir (in sane and approved locations).

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
