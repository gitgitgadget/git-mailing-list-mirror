From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 1 Jul 2008 22:10:16 -0400
Message-ID: <76718490807011910p37ac9bcbjf9fa9748a2eb2e@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
	 <20080701095117.GC5853@sigill.intra.peff.net>
	 <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Adam Brewster" <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 04:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDroV-00048l-1p
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 04:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757947AbYGBCKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 22:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbYGBCKV
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 22:10:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:11436 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYGBCKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 22:10:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so191115rvb.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 19:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ATEDJDS8Dl8G6anvnRzxvoXygjrwWseWPjosyNm6VVQ=;
        b=CWFMOqtlEkleYtnXgUykGIpQZleWRRvYCAXAnTgpkWfuKRY3tsiXC96sZMgGV9f9XF
         /dM/QsbJ5LRCDsxNHeg3Wo5y3xA33v5IHx87zG6IhOwh8xTCZQEAl70+44o3CbqvTQ2C
         iuc8IFx9K9Di++LcxmKVLTgCA5iOWzKajisBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VUHr2Oh4seeb+2U8laN7JSr+eB8XWXtbSwGmLmpikDDOXNEdaN1cCvElH/NQ8Hk+i7
         69q7SdKLBKw6pmeeY4m1AFIeEONpPnRBsTJafZmdQDjywWWNzK0CLXW4sRXj78TikvKA
         CG/S6kotwWwo/Vl9lShtVmG9N8fdo4e9L/D0U=
Received: by 10.141.97.5 with SMTP id z5mr4047658rvl.197.1214964616603;
        Tue, 01 Jul 2008 19:10:16 -0700 (PDT)
Received: by 10.141.33.18 with HTTP; Tue, 1 Jul 2008 19:10:16 -0700 (PDT)
In-Reply-To: <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87077>

On Tue, Jul 1, 2008 at 9:36 PM, Adam Brewster <adambrewster@gmail.com> wrote:
> Maybe I'm a idiot, but I can't find any built-in date to string
> functions that do nice things like print the date the way the user
> says he likes to look at dates.

perldoc -f localtime

j.
