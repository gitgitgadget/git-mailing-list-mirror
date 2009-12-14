From: Johan Herland <johan@herland.net>
Subject: Re: git gc logs to standard error
Date: Mon, 14 Dec 2009 16:55:01 +0100
Message-ID: <200912141655.01268.johan@herland.net>
References: <4B264F7B.8070504@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Richard Rossel <rrossel@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 16:55:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKDGr-0005d8-HO
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 16:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544AbZLNPzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 10:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757570AbZLNPze
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 10:55:34 -0500
Received: from smtp.opera.com ([213.236.208.81]:32840 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569AbZLNPzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 10:55:33 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id nBEFr0fA031177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Dec 2009 15:53:08 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4B264F7B.8070504@inf.utfsm.cl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135220>

On Monday 14 December 2009, Richard Rossel wrote:
> Hi,
> I have a question related to the output of git gc logs. Let me
> explain,
>
> [...]
>
> I realized that the message are sent to standard error,
> so the question is why is the reason to do that?
>
> The quick solution to my problem of annoying mails is send the output
> error to /dev/null
> but what happens when an error really occur, there will be no message
> to alert me.

Try the --quiet parameter to "git gc" (and other git commands).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
