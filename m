From: nguyenki <nguyenki@ensibm.imag.fr>
Subject: Re: [PATCHv2] git-remote-mediawiki: export File: attachments
Date: Tue, 12 Jun 2012 14:54:21 +0200
Message-ID: <7770d61cdb91fff129c35ba2fd97f649@ensibm.imag.fr>
References: <y> <1339505176-2962-1-git-send-email-nguyenkimthuat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:54:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeQcN-0002n7-6J
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 14:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab2FLMy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 08:54:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53192 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164Ab2FLMyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 08:54:25 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5CCjDHt026098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 12 Jun 2012 14:45:13 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5CCsL2h028201
	for <git@vger.kernel.org>; Tue, 12 Jun 2012 14:54:21 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q5CCsLMm025412
	for <git@vger.kernel.org>; Tue, 12 Jun 2012 14:54:21 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q5CCsLnd025411;
	Tue, 12 Jun 2012 14:54:21 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to nguyenki@ensibm.imag.fr using -f
In-Reply-To: <1339505176-2962-1-git-send-email-nguyenkimthuat@gmail.com>
X-Sender: nguyenki@ensibm.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 12 Jun 2012 14:45:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CCjDHt026098
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: nguyenki@ensibm.imag.fr
MailScanner-NULL-Check: 1340109916.5984@ITb7YKUy2WOoyHXgOn60Jw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199783>

On Tue, 12 Jun 2012 14:46:16 +0200, Kim Thuat NGUYEN wrote:

> +			print STDERR "$complete_file_name not a mediawiki file (Not
> pushable on this version of git-remote-mediawiki).\n";
> +		}
>  	}
>  	return ($newrevid, "ok");
>  }

I changed the comment like that, i'll be correct in the nex patch.

-			print STDERR "$complete_file_name not a mediawiki file (Not 
pushable on this version of git-remote-mediawiki).\n";
+			print STDERR "$complete_file_name is not a permitted file. Check 
the configuration of file uploads in your mediawiki \n";
