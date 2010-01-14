From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 09:58:17 +0800
Message-ID: <be6fef0d1001131758x51329f01qeccf477cae54561e@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04>
	 <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
	 <87eilt5uzx.fsf@catnip.gol.com>
	 <be6fef0d1001131737i59b2e843ib032c30027520b54@mail.gmail.com>
	 <fc339e4a1001131749s4da9526bs13406571773c38fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 02:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVEyd-0000xu-E8
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab0ANB6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849Ab0ANB6S
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:58:18 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:41564 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0ANB6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:58:18 -0500
Received: by iwn32 with SMTP id 32so125846iwn.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=9iEQn7X6MQ1yyHXnEWfYy5Ahku6MVYMw2Bb9u2bd/QY=;
        b=Va2RpbMDHAzEgZngS9ooq17DEtb/vyWKG9L7qjvqk6Iak8wbDHLxsw/ZNiWxJ6oh7y
         tS4DYil0ssApiogV8NB4/2UhNUwjjP5x5Zf3S1NgA6yNTfsEJTrsUSh88muxghTlFiu8
         azI7MiuSiInkDHqGqpm99dzIYIwivlN9Db5eE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R4m9jowL0sezPmovZWMHCBtZ42Qf2O85sQT9I+W8Rqpxm0Kz6hgpjw3ED6QLEI+I1v
         G6BXLOBiXPDlmLIARg0oTAyFienHUGXEyVnfNlJIU0DdBJrl9Jnwz8VzvDGOfpxLLw9P
         YI7D0NCWd3gebusevCyuFFWGBv4MOtnRafwtM=
Received: by 10.231.125.19 with SMTP id w19mr166107ibr.8.1263434297504; Wed, 
	13 Jan 2010 17:58:17 -0800 (PST)
In-Reply-To: <fc339e4a1001131749s4da9526bs13406571773c38fd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136923>

On Thu, Jan 14, 2010 at 9:49 AM, Miles Bader <miles@gnu.org> wrote:
> I, and it appears other people, want to make this association at
> push-time -- that's almost always when I make the decision "I'd like
> to track this" -- so the most convenient and intuitive thing would be
> to have a --track option to push.
>
> Of course there could _also_ be some sort of branch sub-command (or
> another command) to setup or change tracking state without pushing.
> But "push --track" is more important for normal usage I think.

Ok, I see your point.

-- 
Cheers,
Ray Chuan
