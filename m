From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Git-aware Issue Tracking?
Date: Thu, 21 Aug 2008 14:55:42 +0600
Message-ID: <7bfdc29a0808210155h48598bev5b9901b14d2d7cf1@mail.gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
	 <20080819175931.GH20947@spearce.org>
	 <200808192121.30372.robin.rosenberg.lists@dewire.com>
	 <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org>
	 <20080820152305.GJ10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5yL-00060n-SA
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbYHUIzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbYHUIzo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:55:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:52573 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYHUIzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:55:43 -0400
Received: by yx-out-2324.google.com with SMTP id 8so435805yxm.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3wsrlCRaBiq006/7M4WXpUCpHWRfYXgce3sQa7VJjsg=;
        b=VdTDtE6PEnh2FWD5kD3DgMjLO7c/jFd1FmcgAcobUxYs8g2i5X+B4X9TV7mrgqxhvD
         UEYlNa95hv/mZGtIFiUocJ/Ygne12j5RsyE7Ka7YD2q8Sfu78mM6eBM/a2YuCaqW2VJi
         f1ZLSQG3QzoBtPFj+MI6tWcF6ZdKKC+K6rwE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LlBGXXKLJ83zSk5f/lxyIo9/Kx04UaZGDIRSMjAYkWjEtt6d7MLVMqFDTxEQPRqWHy
         Jf6ZGb7PdtuHX48z5gEqXxYP4WC/DRNZ0ck4eVOV09dFtUqPsaRvcsiCY59pyam4mpoC
         uo9EEe0G+hH1c85mT7DED/3gyQAWKtEFsK3CQ=
Received: by 10.151.15.9 with SMTP id s9mr1780214ybi.45.1219308942608;
        Thu, 21 Aug 2008 01:55:42 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Thu, 21 Aug 2008 01:55:42 -0700 (PDT)
In-Reply-To: <20080820152305.GJ10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93126>

On Wed, Aug 20, 2008 at 9:23 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Wed, Aug 20, 2008 at 07:13:26AM -0700, Shawn O. Pearce wrote:
>> I've thought about starting a code.google.com project just to use
>> the issue tracking system there.  I'm using an internal tool to
>> keep of issues for myself, but that's not fair to the end-users or
>> other contributors...
>
> I have been thinking about issue tracking for some of my projects too,
> but I'm wondering, does anyone have a comprehensive picture of the state
> of the Git-supporting issue tracking tools, especially those that keep
> the tracked issues in a Git repository as well?
>
>        http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-73b23f376ebd0222d1e4b08f09158172aa34c24f
>
> has three, but two of them are in Ruby, which is rather discouraging.
> But Cil (in Perl) is already "self-hosting", so it might be well usable?

I would also like to see FishEye support git. They have a issue for it
where they have asked interested personnel to place their comment or
vote.

http://jira.atlassian.com/browse/FE-337

Integration with FishEye would mean integration with JIRA as well.
IMO, that would be cool!

Best regards,

Imran

>
> --
>                                Petr "Pasky" Baudis
> The next generation of interesting software will be done
> on the Macintosh, not the IBM PC.  -- Bill Gates
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
