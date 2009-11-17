From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] ls-tree: migrate to parse-options
Date: Mon, 16 Nov 2009 23:02:33 -0800
Message-ID: <4B024A89.2010108@gmail.com>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com> <1258173248-31059-3-git-send-email-bebarino@gmail.com> <7vpr7hisc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:02:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAI5M-0001rF-FA
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 08:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbZKQHCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 02:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbZKQHCc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 02:02:32 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:64310 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbZKQHCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 02:02:31 -0500
Received: by ywh40 with SMTP id 40so3851474ywh.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 23:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=w8jKCSk3gTE2+txz1BiAUC2bppqm3FDWlaE4cNgaMhY=;
        b=gGXzZkX0oHUu2r6yZdDvhaS0U5DQn+XNtRk1I76QX79EuuRxPnSus5AwEqKlbA/bel
         +Q7yKMUU72EdEKJwfek9+J5NMsPq8r/ixhKfCv+WtFZpkveRCttJcHbxBgqqpIYbAUR1
         w1JzxXNzjKOISBidG8E+rRaYe3RdZb8I5NnhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=i+xt7PQNZDNbzfTX6Xzoc31fvciZRadqsKMKtpO0sCU1X4oOdW+CkKw62araIEYBLi
         N0txpp+74Zypkk66HQPWWsHzB+flRRMqA82QN6Y+e2J58TKkX7FfUGVCJndgD8HEOTlI
         WdJMM6CnLK5PPaDAS/P5rEC9UdqTxo1bVp48w=
Received: by 10.150.37.41 with SMTP id k41mr15431828ybk.342.1258441356804;
        Mon, 16 Nov 2009 23:02:36 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 20sm476299ywh.17.2009.11.16.23.02.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 23:02:36 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <7vpr7hisc7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133069>

Junio C Hamano wrote:
>
> @@ -24,7 +24,7 @@ static int chomp_prefix;
>  static const char *ls_tree_prefix;
>  
>  static const  char * const ls_tree_usage[] = {
> -	"git ls-tree [-d] [-r] [-t] [-l | --long] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]",
> +	"git ls-tree <options> <tree-ish> [path...]",
>  	NULL
>  };
>  

Is it [<options>] or [<options>...] or <options> or even <options>... 
though?
