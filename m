X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/4] Rename remote_only to display_mode
Date: Fri, 3 Nov 2006 09:40:55 +0100
Message-ID: <200611030841.05888.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <200611021111.09434.andyparkins@gmail.com> <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 08:41:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JRkVNn5KAOPHCFcR/I66XdZDFCcFbcHOCdOz4gktt+xowBrIwUT2g/wyqcJx47qIAEsNTnEw+UTuL9BriPn+kljNvgdO7sdfyRLUDQiqytkl6up6yUL9+VT7zpSMvOmAgLXoP0q1HOQNLQJEejfghkRh8mbFvCUZANQWas+WjMQ=
User-Agent: KMail/1.9.5
In-Reply-To: <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30797>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfubz-000377-Q4 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751781AbWKCIlL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 03:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWKCIlL
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:41:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:17116 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751352AbWKCIlK
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 03:41:10 -0500
Received: by ug-out-1314.google.com with SMTP id m3so350632ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 00:41:09 -0800 (PST)
Received: by 10.66.242.5 with SMTP id p5mr2286157ugh.1162543268791; Fri, 03
 Nov 2006 00:41:08 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 39sm547383ugb.2006.11.03.00.41.08; Fri, 03 Nov 2006 00:41:08 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 02:40, Junio C Hamano wrote:

> If you make this a "mode", it probably is better to make 1 and 0
> into symbolic constants.  This patch taken alone is regression
> in readability.

In my own code I would have done exactly that; however I've been trying to 
keep my patches as minimal as possible.

Digressing a little: what is the polite form of patches for git?  My strategy 
with this set was to make each patch as small as possible to reach my end 
point.  If those patches were okayed on the list, I could then do a "make 
more beautiful" patch, which is really nothing to do with the original 
changes to functionality but would make the code prettier.  Really I'm asking 
what level of intrusiveness of patch is not considered rude?  In making my 
patches, should I ride rough-shod over current implementation and just do it 
how I'd do it or should I try to fit in (as I did in this case)?

> Something like this untested patch, that is...

I'm very much in favour; I shall make changes of this form soon.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
