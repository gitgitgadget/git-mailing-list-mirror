From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 0/6] archive: refactor and cleanup
Date: Tue, 15 Jul 2008 02:27:25 +0200
Message-ID: <487BEEED.8030104@gmail.com>
References: <487BA74E.5070208@lsrfire.ath.cx> <487BE440.9010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 02:28:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIYP9-0005x0-H9
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 02:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbYGOA1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 20:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbYGOA1a
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 20:27:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:52969 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbYGOA1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 20:27:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2190989fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=ewIeB6rg4S/QbPDM5aEO3BZZN3poOpby/yb+YVlTuQ8=;
        b=S5M4mYEwAm4/ICn6S4Cpcztt8eYQaQTsfQhGeKzHG17SkoLvGl/PvlGVWlVJrpBDCT
         1kRTxYz32455Yq628/jo4wOWEQ6t1qI4qWNK5wEOBREfUhbmmYdRzszRR2LYtWeVJyBf
         eMvh5OcvvKhgj61sk4Qy6r+lxQ6fB5ARn1juk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=KVwvIi7x/KrcjOuPr2+fL+9h+jEifgHelhOkwNWPhxRtbscyl0fnLcNZ3Xnpd9gdeM
         fHB3p4o8CnUNzDbc/aaw8TTgkUDx7bo0mhLDf40BOYYV46KJ07XJT675V5l0fn1T+YEN
         nHlG0gl3ngcl7QVeF1CqD0CZup6Om+e5kILgA=
Received: by 10.86.80.17 with SMTP id d17mr15045229fgb.47.1216081648053;
        Mon, 14 Jul 2008 17:27:28 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id d4sm8187119fga.8.2008.07.14.17.27.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 17:27:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <487BE440.9010006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88488>

Lea Wiemann wrote:
> * Unless you have a specific reason, I suggest that you don't Cc Junio
> on patches; he reads all messages on this list (more or less) and will
> usually simply apply your patches once they're reviewed.  (Watch for his
> periodical "What's cooking in git.git" messages to see if he got them.)

Uh, I just noticed that you have enough commits in git.git that you
probably didn't need this lecture. ;-)  Sorry, Rene.  (Thanks Dscho for
the pointer.)
