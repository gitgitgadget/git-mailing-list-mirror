X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 3 Nov 2006 19:36:04 +1300
Message-ID: <46a038f90611022236q6392a4d3ue261c935506b5ea1@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <20061021174056.GA29927@artax.karlin.mff.cuni.cz>
	 <Pine.LNX.4.64.0610211102250.3962@g5.osdl.org>
	 <200610212121.58245.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 06:36:20 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Jan Hudec" <bulb@ucw.cz>,
	"Jeff King" <peff@peff.net>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AgRu89OMZ07kaEd7Upk6RHZ1Tk1/cbA5tPnlT3ytSPkHhoXLTDLFvsOLqdF67xE47jQA0br4T0YgLHzVfm8HEuBpMZHmXbGSiOE0RGBbcaRq0AUSW6ohnaqp7oyfj5tWLismcXHhaus1GCtU3vdaRU4eTg5vlxb3SnpxKT+yFJc=
In-Reply-To: <200610212121.58245.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30787>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfsey-0002sx-Pg for gcvg-git@gmane.org; Fri, 03 Nov
 2006 07:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753152AbWKCGgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 01:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbWKCGgJ
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 01:36:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:38070 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1753152AbWKCGgG
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 01:36:06 -0500
Received: by nf-out-0910.google.com with SMTP id m18so25846nfc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 22:36:05 -0800 (PST)
Received: by 10.48.254.10 with SMTP id b10mr709332nfi.1162535764668; Thu, 02
 Nov 2006 22:36:04 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Thu, 2 Nov 2006 22:36:04 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 10/22/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Lack of --follow is not a big issue because you can do this "by hand";
> you can use git-diff-tree -M at the end of file history to check if
> [git considers] it was moved from somewhere.

This 'by hand' can be done in shell. cg-log has a half-complete
implementation of it. Seems to be disabled now :-(

cheers,


