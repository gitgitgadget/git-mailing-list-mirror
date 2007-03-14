From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 10:45:55 +0000
Message-ID: <200703141045.58739.andyparkins@gmail.com>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com> <7vodmwfg2c.fsf@assigned-by-dhcp.cox.net> <20070314074440.GC12710@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	James Bowes <jbowes@dangerouslyinc.com>,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 11:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRQzj-0007yE-4v
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 11:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbXCNKqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 06:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbXCNKqH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 06:46:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:12366 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161110AbXCNKqG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 06:46:06 -0400
Received: by wr-out-0506.google.com with SMTP id i28so118483wra
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 03:46:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gs9HMqGTai11pbu8iRVJWmpVgwgZMIL2fGPqeH72Cp0UYq84IEVxcGYEY/9PtYRGvzAmbhY5orslHmMLZxLoV6HOqBKXcyE11RQNN705LMTaJGaYi6vr84IXnUgNjdroRiGePkQoF4sxiC12b/6vA3rrKB3o7lNMvHjqK1xVj9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bdDt/XeqyqNK9uGx8QDQqG5+/MfPYluicVvTy9X9ugb3ROUG50oQTU3+McBb92ZZ7lTiq3ZdUWlB1oKtzdFxxb3zI2CkwG51zOeL8EwkI7kr1j3pexicGG2q+5dxUBLr2tHnbCeFYVir0phVMywWiSf/l3m6PzxM4FURyyjOmxc=
Received: by 10.65.248.19 with SMTP id a19mr4073620qbs.1173869163710;
        Wed, 14 Mar 2007 03:46:03 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id x1sm6537574nfb.2007.03.14.03.46.02;
        Wed, 14 Mar 2007 03:46:02 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20070314074440.GC12710@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42196>

On Wednesday 2007 March 14 07:44, Theodore Tso wrote:

> I agree with Junio; I think the scripts are much more readable and
> easier to understand; In fact, it would be nice if the script were
> preserved somewhere, perhaps as comments in the .c file.

If only there were some tool that would keep collections of files as a 
snapshotted whole and allow us to browse the history of those snapshots in 
some sort of connected graph, with each snapshot being given some sort of 
unique ID.  Then we could simply refer to that unique ID when we wanted to 
tell someone about a particular historical instance.

:-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
