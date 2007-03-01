From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 1 Mar 2007 11:40:10 +0000
Message-ID: <200703011140.11108.andyparkins@gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net> <7vr6s9th4f.fsf@assigned-by-dhcp.cox.net> <7vhct5rztc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Martin Langhoff" <martin.langhoff@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 12:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMje0-00079k-Ci
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbXCALkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbXCALkS
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:40:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:4670 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbXCALkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:40:16 -0500
Received: by nf-out-0910.google.com with SMTP id o25so862747nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 03:40:15 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aFxPmNHXUeVxeihoqRkXnD7yMqEIj+yE4dkghr2/PZkNMlD7VTSOXfAd/Ca63qEgBaMo4xIx6WEuGKvr7mTNgKiZCz/XU8so9Al4ZxDUE5Hg/pIR1E1d+9xtk+mlYS/bOcibz7hn54C1EhLnsHth5aAT7MLzaliqu68mweWqqpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YsUNzwwlvYKYBKhkWKJw03JIgGyQFeLjcbvp+SMRQQwK/cjbTptPM8fi7glWIIXWw1pJXGTWSmBSdM66acwQ1uiFffOK72QKEpGPshLFaZ/nfIFgpwcz2k054g9DUsDv4NHwf/0nKzQ1Tb3vjuSJvJbKuDGz8JCbJ0QrEznTlvM=
Received: by 10.48.204.5 with SMTP id b5mr5521732nfg.1172749215329;
        Thu, 01 Mar 2007 03:40:15 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id r34sm8670852nfc.2007.03.01.03.40.13;
        Thu, 01 Mar 2007 03:40:13 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vhct5rztc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41086>

On Thursday 2007 March 01 11:03, Junio C Hamano wrote:

> Once we separate out the handler section, we can introduce more
> useful variables in it (not the "pretty", whose sole purpose was
> to have fun and serve as a demonstration).  Obvious ones are:
>
> 	; takes temporary files old, mine, his and writes the
>         ; result in another
> 	merge = "cmd external-merge-command %s %s %s %s"
>
> 	; takes two temporary files
>         diff = "cmd external-diff-command %s %s"

I was part way through assembling a document when I read this; I hadn't 
thought of the external merge option.  I'll add that and send the document 
soon.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
