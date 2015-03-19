From: Kevin D <me@ikke.info>
Subject: Re: [v3 PATCH 2/2] reset: add tests for git reset -
Date: Thu, 19 Mar 2015 23:16:52 +0100
Message-ID: <20150319221652.GE11832@vps892.directvps.nl>
References: <1426667709-26698-1-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:16:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYikL-00055U-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 23:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbbCSWQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 18:16:53 -0400
Received: from ikke.info ([178.21.113.177]:50526 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbbCSWQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 18:16:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 710001DCF6D; Thu, 19 Mar 2015 23:16:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1426667709-26698-1-git-send-email-dyoucme@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265848>

On Wed, Mar 18, 2015 at 02:05:09PM +0530, Sundararajan R wrote:
> The failure case which occurs on teaching git is taught the '-' shorthand
> is when there exists no branch pointed to by '@{-1}'. But, if there is a file
> named - in the working tree, the user can be unambiguously assumed to be 
> referring to it while issuing this command.
> 

The first line is hard to read. I think the "is taught" part is
redundant.
