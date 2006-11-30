X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 22:50:23 +0700
Message-ID: <fcaeb9bf0611300750t4adb4c97ibd65bc5b254e7efa@mail.gmail.com>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	 <7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	 <87ac2cwha4.wl%cworth@cworth.org>
	 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	 <878xhwwdyj.wl%cworth@cworth.org>
	 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	 <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <ekmkoe$a52$1@sea.gmane.org>
	 <ekmlf4$ask$3@sea.gmane.org> <m2odqpm0d6.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 15:50:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EiZl/rpooqVeTvxAfQftiHgojmjvIqEjRrJkSC2mTZrXUX317sfuOK52uE/LEuHThRW4UYVKEfv9c0KaSPW/PiEvgaE7IOSAQ7ecJwF3/N9O/xsG3EEgtc66uaFQtTQ2F+VK6anoWIFDVS3lTAZkxNc+OH4emq+6hSmUsctVG8w=
In-Reply-To: <m2odqpm0d6.fsf@ziti.fhcrc.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32757>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoBB-0008Sr-Fj for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030609AbWK3Pu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWK3Pu0
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:50:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:20241 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1030609AbWK3PuZ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:50:25 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1017404wra for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 07:50:24 -0800 (PST)
Received: by 10.78.185.7 with SMTP id i7mr3651947huf.1164901823885; Thu, 30
 Nov 2006 07:50:23 -0800 (PST)
Received: by 10.78.118.16 with HTTP; Thu, 30 Nov 2006 07:50:23 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/30/06, Seth Falcon <sethfalcon@gmail.com> wrote:
>
> For those using emacsclient, I don't think ^C will work.  Is there
> another way to undu an ammend commit?  If not, is there any sense in
> detecting a magic comment to abort the ammend commit?

Uncomment to abort commit would be more intuitive.

-- 
