From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Re* git clean --exclude broken?
Date: Thu, 25 Aug 2011 20:38:38 +0200
Message-ID: <4E5696AE.4010201@elegosoft.com>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net> <7vliuio65w.fsf@alter.siamese.dyndns.org> <7vfwkqmfsh.fsf@alter.siamese.dyndns.org> <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Todd Rinaldo <toddr@cpanel.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 20:39:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwepb-0008KC-KN
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 20:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab1HYSjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 14:39:05 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:42456 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474Ab1HYSjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 14:39:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 7E264DE77D;
	Thu, 25 Aug 2011 20:39:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GmdGnQCuLw7r; Thu, 25 Aug 2011 20:38:57 +0200 (CEST)
Received: from [192.168.1.101] (e178169245.adsl.alicedsl.de [85.178.169.245])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 987A2DE057;
	Thu, 25 Aug 2011 20:38:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180099>

On 08/25/2011 08:29 PM, Junio C Hamano wrote:
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 974e04e..a7a18e3 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -47,9 +47,9 @@ OPTIONS
>  
>  -e <pattern>::
>  --exclude=<pattern>::
> -	Specify special exceptions to not be cleaned.  Each <pattern> is
> -	the same form as in $GIT_DIR/info/excludes and this option can be
> -	given multiple times.
> +	In addition to what are found in .gitignore (per directory) and
> +	$GIT_DIR/info/exclude, also consider these patterns to be in the
> +	set of the ignore rules in effect.

Nitpick: Shouldn't this be "In addition to what is found in .." or
"In addition to those found in .."?
