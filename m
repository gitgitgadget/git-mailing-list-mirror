From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 1/4] test-svn-fe: split off "test-svn-fe -d" into a
	separate function
Date: Tue, 31 May 2011 12:18:24 -0400
Message-ID: <1306858704.13283.2.camel@drew-northup.unet.maine.edu>
References: <BANLkTi=O9AeOZTHVLbq+rKv5k-CqNGb+LQ@mail.gmail.com>
	 <BANLkTinpta+a4MAr0e2YtMa1Kr1QcJmYWg@mail.gmail.com>
	 <20110525235520.GA6971@elie>
	 <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
	 <20110527110828.GA7972@elie>  <20110527110914.GB7972@elie>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Barr <davidbarr@google.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 18:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRReh-0001xx-BE
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 18:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab1EaQSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 12:18:50 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:54798 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab1EaQSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 12:18:49 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4VGISp7000573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 May 2011 12:18:28 -0400
In-Reply-To: <20110527110914.GB7972@elie>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4VGISp7000573
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1307463510.00286@7pCD0CQJQHyDOVX7ompb+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174810>


On Fri, 2011-05-27 at 06:09 -0500, Jonathan Nieder wrote:
> The helper for testing the svndiff library is getting dangerously
> close to the right margin.  Split it off into a separate function so
> it is easier to contemplate on its own.
> 
> In other words, this just unindents the code a little.  No functional
> change intended.

>  
> +static const char test_svnfe_usage[] =
> +	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";

>  int main(int argc, char *argv[])
>  {
> -	static const char test_svnfe_usage[] =
> -		"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";

How is this germane to the original intent? Is there a gain by making it
global (to that file) that I'm missing?

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
