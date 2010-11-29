From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] web--browse: split valid_tool list
Date: Mon, 29 Nov 2010 10:44:35 -0600
Message-ID: <20101129164435.GI8037@burratino>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 17:46:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN6ru-0004tZ-B4
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 17:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab0K2QqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 11:46:02 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55271 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab0K2Qop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 11:44:45 -0500
Received: by wwa36 with SMTP id 36so4913414wwa.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5Gs7NHqn7L5yoGr5i/CNhO8u94o4yd9yyg3QfqOyaqY=;
        b=U1ThmtFQLxs4o8qlFGhvfZJvIvzYeP3mGdGame2tSPgBp1L+JrzKVXB1e4WCBqU/Ye
         khRzj89TmIjq5H0YmtAu07adDAj5FGfs97YPveaA17TuWqa4RkZCROhBC0GeDc351Bd7
         Tz/D9ED5jiM3PvDE+Z5N/H5HZLJfUysSUfkpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P0RG37JDCeS/D0mmGiJibla6jfw/6C21JHBMVQKlvgKXkZOhTh9wVY+LXiQHLmGaH5
         4gunxDq4CTCivAgT2zkCQdIsfKpoL5edFksFX+ji83JB7QZ6GOlzDFsOLKG0qeNyHFSw
         DFKC1HphBOEPHayltZVWhCOmuEBb5wh1k9whk=
Received: by 10.227.9.79 with SMTP id k15mr6189475wbk.101.1291049083868;
        Mon, 29 Nov 2010 08:44:43 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id x28sm2488675weq.16.2010.11.29.08.44.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 08:44:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291042075-19983-4-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162399>

Giuseppe Bilotta wrote:

> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -31,7 +31,8 @@ valid_custom_tool()
>  
>  valid_tool() {
>  	case "$1" in
> -	firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
> +	firefox|iceweasel|chrome|google-chrome|chromium\
> +	|konqueror|w3m|links|lynx|dillo|open|start)

micronit: I think this looks better as

	firefox|iceweasel|chrome|google-chrome|chromium| \
	konqueror|w3m|links|lynx|dillo|open|start)

, with the | on the end of the first line.
