From: Andy Parkins <andyparkins@gmail.com>
Subject: OT: Favourite log message layout
Date: Wed, 28 Feb 2007 09:48:01 +0000
Message-ID: <200702280948.05391.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0702272313020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Josefsson <simon@josefsson.org>, junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 10:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMLPy-0004RZ-K6
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 10:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbXB1JsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 04:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbXB1JsM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 04:48:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:16559 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbXB1JsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 04:48:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so498828nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 01:48:09 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=q0xzA52l1RxRF6ZEIAzm9ciHzzMp4zBGe2WG9wvGQphsBCgLoD4K0zP9Mhch+gLHedcyL96RY/E4VCT3wmEyrCDrJKBXrFBRf1qCDyXeWY0abQuEiDN9qIDw1q7LO/YNBzDKmXs4TTMYDcwztUVm955WuL0Ms/gRZANyATa7LDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZwyUsQn2ysZtndbTMahfNVfxpcl/Yr0lJOeoxsX/yBHm25fSXRixMKVAllaX2k/sqEmE9oNw1JBt42jHVCh41QauPX6rWQfG07q/45zaB4ooeyMJ4WPEUX0ucuRufrVjmMwgfjyWAsVPpR/l9Ab2G9DtmFK8COO6cptOxWQHsJk=
Received: by 10.48.202.14 with SMTP id z14mr3201936nff.1172656089910;
        Wed, 28 Feb 2007 01:48:09 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id p72sm5192489nfc.2007.02.28.01.48.07;
        Wed, 28 Feb 2007 01:48:07 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40912>

On Tuesday 2007 February 27 23:02, Linus Torvalds wrote:

> I don't think the GNU style ChangeLog is particularly good. In fact, I
> think it has an unfortunate tendency (thanks to being per-file-log) to
> encourage people to commit unrelated changes and then explain them per
> file.

Me either; however, I do like per-file information.  My own favoured format 
for log messages is (with all but the shortlog optional)

---- 8< ----
Short log message summarises changes in one line

Longer message summarises changes, perhaps with reasons for change and why 
this change fixes something.

file1.c
 * detailed description of change to this file
 * more changes

file2.c
 * detailed description of change to this file
---- >8 ----

That's not to say that this is an excuse to lump unrelated changes together, 
but it does allow one to say

 file1.c
  * Added function xyz()

 file2.c
  * Call new function xyz() to achieve clever feature

when it's appropriate.  I've found this particularly useful in conjunction 
with git-blame.  You find the revision that made a change in a particular 
file then the log message is easily searched to find the exact reasons for 
that change on that line in that file.

Perhaps I'm overly verbose though.  I do like the sound of my own voice - even 
on log messages :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
