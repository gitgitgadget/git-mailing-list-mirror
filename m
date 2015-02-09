From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 9 Feb 2015 13:53:50 -0800
Message-ID: <20150209215350.GU29365@google.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mingo@kernel.org, stable@vger.kernel.org,
	greg@kroah.com
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: stable-owner@vger.kernel.org Mon Feb 09 22:54:01 2015
Return-path: <stable-owner@vger.kernel.org>
Envelope-to: glks-stable3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <stable-owner@vger.kernel.org>)
	id 1YKwHH-0003jn-Rh
	for glks-stable3@plane.gmane.org; Mon, 09 Feb 2015 22:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760753AbbBIVx6 (ORCPT <rfc822;glks-stable3@m.gmane.org>);
	Mon, 9 Feb 2015 16:53:58 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32979 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760442AbbBIVx5 (ORCPT
	<rfc822;stable@vger.kernel.org>); Mon, 9 Feb 2015 16:53:57 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz1so7728927pad.9;
        Mon, 09 Feb 2015 13:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LxRgDLTtOcpA/qdWdF8MG5amn4jLPmwaemcR6F2m3y8=;
        b=ZZtCzwvYruHy2MNsiZwLkSA9dv62YAhTo3iuOE2HzVqELxTptFCg5Wx+HBe+KuLO64
         RKcSgrQvit6CQZqmFs6beFWm2fqMrh1zHFUUElJZRY9DQ2XWJC53OaJkFp1CHRHZPvC7
         M5goA5mX842ApqySpvTEnCOpilmrcKzu1WVn2HLIS2BDBbJtKiZtfQpzvUMYAnsplfPF
         l68ZZgBqOdKDzZkL2NiJbQN6z8LVTXgdSTQ1GfkCevorwpKK7qqvqW1bAMXWujgOnrjJ
         FoH8hk63Sbov+sPNQHcgmzTNOx+ZPfj0g+b9PO/v6kwio33QzBiYbW+6ItJin/jk0kvw
         tlYQ==
X-Received: by 10.67.1.132 with SMTP id bg4mr31541807pad.151.1423518836872;
        Mon, 09 Feb 2015 13:53:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b80b:4923:be66:2d21])
        by mx.google.com with ESMTPSA id mt4sm17308186pdb.55.2015.02.09.13.53.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Feb 2015 13:53:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150209194224.GA27482@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263609>

Hi,

Paul E. McKenney wrote:

> Cc: <stable@vger.kernel.org>
>
> Yet I cannot allow git-send-email to actually send email to that address,
> lest I get an automated nastygram in response.

Interesting.  Last time this came up, the result seemed to be
different[*].

Thanks,
Jonathan

[*] http://thread.gmane.org/gmane.comp.version-control.git/178926/focus=178929
