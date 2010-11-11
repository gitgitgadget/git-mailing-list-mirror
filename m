From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 10/11] gitweb: group remote heads by remote
Date: Thu, 11 Nov 2010 20:25:29 +0100
Message-ID: <201011112025.30095.jnareb@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com> <1289478378-15604-11-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 20:25:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcmL-00070B-Qb
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab0KKTZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:25:42 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39674 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab0KKTZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:25:41 -0500
Received: by fxm16 with SMTP id 16so1638536fxm.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4GwWN+IqFJmSmIXoajlCNjNlmzMU3TpQ/AJJIBb/H28=;
        b=ZpjM5JBM1lPYc12vi6m7IzH6T9hgDtJjEp/p7c3jE1NIMmwYXoxvihn6l1CWF+iYTl
         bCkZNTS5esuoPZWBG9kjXP4YChbu5u/DotxTnSR88flwIQ7bEhQIciJdj0stH4lS3cUz
         u0/JSfg4U8EAC3qjGaWxXUW2kgTVlRRfPFQv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FV6qC/Gj9Ytp8blbmHcK8GuvsMlWXMMIVl5LeqoWMYIMKySMNUc7mSZ+KcsZ96rty/
         iAzIfrqVf5+Xxmt1EQRBOqGXmp0FnsFOR3fZ5veez+P8VXpOU8mmxFrIu1npUga+0RV2
         ao/SKOQn2VfqiEH4oE/j7+3rMrwvzP9Pn1cc8=
Received: by 10.223.74.193 with SMTP id v1mr547740faj.105.1289503540260;
        Thu, 11 Nov 2010 11:25:40 -0800 (PST)
Received: from [192.168.1.13] (abvw231.neoplus.adsl.tpnet.pl [83.8.220.231])
        by mx.google.com with ESMTPS id l14sm1102425fan.9.2010.11.11.11.25.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 11:25:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1289478378-15604-11-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161295>

On Thu, 11 Nov 2010 at 13:26, Giuseppe Bilotta wrote:

> +# Returns a hash ref mapping remote names to their fetch and push URLs.
> +# We return a hash ref rather than a hash so that a simple check with defined
> +# can be used to tell apart the "no remotes" case from other kinds of
> +# failures. The mapping can be restriced to a single remote by specifying its
> +# name as optional parameter to the call.

Errr... it is now hash or hash ref.

[...]
> +sub git_get_remotes_list {
[...]
> +	close $fd or return;
> +	return wantarray ? %remotes : \%remotes;
> +}

[...]

> +# Display remote heads grouped by remote, unless there are too many
> +# remotes ($have_all is false), in which case we only display the remote
> +# names
> +sub git_remotes_body {
> +	my ($remotedata, $limit, $head) = @_;
[...]

What $have_all?


But with exception of those out-of-date comments I like this version.
Thanks.
-- 
Jakub Narebski
Poland
