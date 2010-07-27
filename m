From: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
Subject: Re: [bash-completion] syntax error near unexpected token '<' on
 line 123 in bash_completion.d/git
Date: Tue, 27 Jul 2010 12:43:48 +0200
Message-ID: <1280227428.7654.5.camel@soho.example.org>
References: <1280056320.7883.9.camel@soho.example.org>
	 <4C4C982C.20904@pileofstuff.org> <1280096368.7211.2.camel@soho.example.org>
	 <4C4E00AE.7010904@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:44:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odhdg-0006kS-JW
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab0G0Knz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 06:43:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58431 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab0G0Kny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 06:43:54 -0400
Received: by wyf19 with SMTP id 19so2910827wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=SeBZB43jsWL/DZ1+7qO2aQ3se0FcgIGuXX3o0H6D71w=;
        b=G/vHboc9djKD89Mywi546Zd77BRp1jNNg6bWC0QWpskAMjShB9Q9tN+tlVpCLD25+y
         4DxsPURi2pm1cldXmcMyhsxj7oc2z1qWQCFsF71JcZNkwiazkC03KCxRxzwJ9BsfnfQc
         EBx6rUggGduinB032O1LMztSNNBwSyuCO8MCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JC2rUS2DFIgYT29nwfFWzkSkbn0t1nYv+0y8s94MVPOzP/halcV4ucbk4bNgCYIW3r
         wtMDQuRFaRPGdRWAnm/sdSWm1f5yWIvwIzgx5wAh+y2Ry4lrREfqeCmKoWzlewuOVWik
         Aa87/J9nEq9Ce5SScTXdQtH9OfhNUMW17ggg8=
Received: by 10.227.158.15 with SMTP id d15mr4916720wbx.46.1280227433178;
        Tue, 27 Jul 2010 03:43:53 -0700 (PDT)
Received: from [192.168.0.50] (ARennes-553-1-38-213.w86-214.abo.wanadoo.fr [86.214.125.213])
        by mx.google.com with ESMTPS id e31sm4101304wbe.5.2010.07.27.03.43.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 03:43:50 -0700 (PDT)
In-Reply-To: <4C4E00AE.7010904@pileofstuff.org>
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151931>

it appears there is a bug in /etc/profile in archlinux that mis-detects
sh as bash and run bash specific script like bash_completion.
