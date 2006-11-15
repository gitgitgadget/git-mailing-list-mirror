X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:02:14 +0000
Message-ID: <200611151902.16358.andyparkins@gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611151000460.2591@xanadu.home> <7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 19:05:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Hq6f6T+by5m/UPI2hSuZ6WR6MgegdltR0d5DN06YO07gXgJo3B2eu0Puq+2Qv7rTHPtvalkikqcRj/9IIjPe2gkj6OwUPOFMGJWgXD9xZSdZBv18PfavFDj03FU357vyKuoANFZORYNw3VF4Zmc7dY3DQ9H4zvf5+ETYnlNvFE4=
User-Agent: KMail/1.9.5
In-Reply-To: <7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31468>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQ4w-0005Zz-Hx for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030895AbWKOTE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030886AbWKOTE6
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:04:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:11564 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030895AbWKOTE5
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:04:57 -0500
Received: by ug-out-1314.google.com with SMTP id m3so229271ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 11:04:56 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr2290851ugh.1163617495439; Wed, 15
 Nov 2006 11:04:55 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 32sm1302668ugf.2006.11.15.11.04.55; Wed, 15 Nov
 2006 11:04:55 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, November 15 18:16, Junio C Hamano wrote:

> I still think in the long run you would be better off giving
> separate names to Porcelains because I am sure you are going to

The problem I think with that is that the line between plumbing and porcelain 
is not clear.  If you have two names then for the ambiguous ones you are just 
making it more confusing because there is yet another variable to try before 
you get the function you want.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
