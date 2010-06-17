From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: moving a remote branch?
Date: Thu, 17 Jun 2010 17:05:33 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483CEEB6D@xmail3.se.axis.com>
References: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
	<AANLkTimTSU7Db7cMlC0ZxQ47IoBUr4Ee4G-GfgDoYLmK@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC74483CEEA82@xmail3.se.axis.com>
 <AANLkTikbOLRc6BvXtO8vznFevj0V_iZr34U1QaHCfFBh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Nazri Ramliy <ayiehere@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 17:05:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPGf4-0006kt-GS
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 17:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924Ab0FQPFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 11:05:39 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:45703 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802Ab0FQPFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 11:05:38 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o5HF5YSq025057;
	Thu, 17 Jun 2010 17:05:34 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 17 Jun 2010 17:05:34 +0200
Thread-Topic: moving a remote branch?
Thread-Index: AcsOJ65r88t3g26oTaWLRZLaPZguTAABcK0w
In-Reply-To: <AANLkTikbOLRc6BvXtO8vznFevj0V_iZr34U1QaHCfFBh@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149311>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Thomas Anderson
> Sent: den 17 juni 2010 15:56
> To: Peter Kjellerstedt
> Cc: Nazri Ramliy; git@vger.kernel.org
> Subject: Re: moving a remote branch?
> 
> Do I need to switch to the local featurea branch before doing "git
> push origin origin/featurea:refs/heads/featureb" or can I do that
> while in the default branch?

You do not need to switch branch. The command above has all
the information it needs on the command line.

One thing to note though. If you have a local branch tracking
the remote featurea branch, it will not automatically start
tracking the featureb branch when you rename the remote branch.
You will have to fix the tracking manually (either by setting
up a new tracking branch for featureb, or by editing the
.git/config file to reflect the new situation).

//Peter
