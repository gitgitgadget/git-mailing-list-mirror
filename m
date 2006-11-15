X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: git fetch --reference?
Date: Tue, 14 Nov 2006 17:17:04 -0800
Message-ID: <f2b55d220611141717r4507c9demddb1cf872dbee073@mail.gmail.com>
References: <f2b55d220611141638k5f4a0aeas1a43301e4b40bf59@mail.gmail.com>
	 <7vy7qdttc0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 01:17:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KRXV/h7EdrG2agID8dgTBWenjCrrcVdN7BZKIefJo1j5QFyBe0lY6MKe2v1Sh4aDhbjPBWN+pDxVgfZL3cQzj/3w+C4hz43deuuu0uhL0uMr+6bdBQbFp1npkJ9fx5X+zd1gvbflpgqCBI6BHyq7/H5nELDrGprh2JOTDCMopS8=
In-Reply-To: <7vy7qdttc0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31400>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk9Or-0007qv-PJ for gcvg-git@gmane.org; Wed, 15 Nov
 2006 02:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966606AbWKOBRH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 20:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966608AbWKOBRH
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 20:17:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:53637 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S966606AbWKOBRE
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 20:17:04 -0500
Received: by wx-out-0506.google.com with SMTP id s7so24297wxc for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 17:17:04 -0800 (PST)
Received: by 10.90.27.6 with SMTP id a6mr1830656aga.1163553424392; Tue, 14
 Nov 2006 17:17:04 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Tue, 14 Nov 2006 17:17:04 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/14/06, Junio C Hamano <junkio@cox.net> wrote:
> I am somewhat doubtful that this is common enough to warrant
> adding an extra option to "git fetch", but you could add
> alternates to these new reference object stores before
> initiating the fetch.
> ...

Thanks, that's what I was looking for.  I can just set up a "tracking"
tree where I don't attempt any merges, include it in the alternates
for each working tree, and "git fetch" in the tracking tree when it's
convenient.  Now, will tags from the tracking tree propagate into the
working trees?

Cheers,
