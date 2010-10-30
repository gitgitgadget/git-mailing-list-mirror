From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/11 v4] More consistant terminology
Date: Sat, 30 Oct 2010 01:58:44 -0500
Message-ID: <20101030065844.GB30613@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288411819-24462-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 30 08:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC5PF-0003QY-Sa
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 08:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab0J3G6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 02:58:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64784 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0J3G6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 02:58:54 -0400
Received: by gxk23 with SMTP id 23so2403841gxk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wY4iCmqADNIWFJeu/dd9isW0mHxKPsK3sVOq/bsRZo0=;
        b=sR2fX4fdt71BQC9u6TPUN8tmdWVTISiz49HU4nGqrAdwuSMy1xzSbEDvHjxZC5wNDJ
         j/36JkMUD0Zp9LYPXH1AI0wVSJyN3Aq1edft4az43CFydH9aeOPrlmdMfW4hbuRRCDkw
         4c5IffSCwCqPGMA1LM4ofmpVJ9t+AmOd1Jvk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YRwT8+KYnfpDUqeeffO8bDgeaSiFsSF8jHC63mJOemK7Z8WvCOcPiPkOfiELn9MdZq
         dGdD1EjggDVhWoRnDrswCCBOxQUOqGIcbOOPayOYIlLF60HG71lulRT1D5MrMWeJcgYf
         Tec23uRjgfAN2DylUY68TP8lbVk5UdtMH69rQ=
Received: by 10.90.26.11 with SMTP id 11mr608922agz.174.1288421933192;
        Fri, 29 Oct 2010 23:58:53 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z70sm2530384yhc.36.2010.10.29.23.58.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 23:58:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288411819-24462-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160388>

Matthieu Moy wrote:

> Jonathan Nieder (1):
>   user-manual: remote-tracking can be checked out, with detached HEAD
> 
> Matthieu Moy (10):
>   Better "Changed but not updated" message in git-status
>   Replace "remote tracking" with "remote-tracking"
>   Change remote tracking to remote-tracking in non-trivial places
>   everyday.txt: change "tracking branch" to "remote-tracking branch"
>   Change "tracking branch" to "remote-tracking branch"
>   Change incorrect uses of "remote branch" meaning "remote-tracking"
>   Change incorrect "remote branch" to "remote tracking branch" in C
>     code
>   Use 'remote-tracking branch' in generated merge messages
>   user-manual.txt: explain better the remote(-tracking) branch terms
>   git-branch.txt: mention --set-upstream as a way to change upstream
>     configuration

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Sorry to draw this out so (and thanks for your work!).

IMHO patches 7 and 8 should be squashed to avoid breaking the
fetch/fmt-merge-msg interface, but there is no need to resend again
to make that happen.
