From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 13:51:56 -0500
Message-ID: <AANLkTim=P6GwnhuaJrixCZB_USD0NrKT0nN4t6XyEY+6@mail.gmail.com>
References: <4C7681F1.3070205@workspacewhiz.com> <7vy6btl2yo.fsf@alter.siamese.dyndns.org>
 <4C76B6CF.8040808@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 20:52:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OohYy-0003qm-1P
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 20:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab0HZSwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 14:52:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58429 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0HZSwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 14:52:16 -0400
Received: by yxg6 with SMTP id 6so782707yxg.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=2/NG2bLIzABzVzZFjwTrnlFXdGIFTcqN/AMr0GHltHY=;
        b=MYmm+mM65IaHeXuJxYMgkpA20HkEXxQobhm/3pRJFxtpEaVEhuoMysxUXBEJwpeutz
         j/YUxNAMQZntGZa0kYizBEa9wHJDUI6S0cMc/zGbOIpIzrO3LH68XAmsIrRmOB1j+Kd3
         YPMDZBODiteKQXU4GvA595qp2OIEOBcugaaQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Kyjjk1vM1097rpBR7GjEjh5L9aaozvKqFJKvRlPQKnTqHie2KbtdDIhB9Eo0LDyDjX
         soV+3HxGisxDdjI9gnlyvwpCr+JA75+5RpPCM5f/2Ss4liMMlhxFOnQOfcGA3zLAsBP0
         jcjKJutpUdrep1hnpC4TQUbhAIGOo5xAQUVdo=
Received: by 10.151.156.4 with SMTP id i4mr546733ybo.370.1282848736123; Thu,
 26 Aug 2010 11:52:16 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Thu, 26 Aug 2010 11:51:56 -0700 (PDT)
In-Reply-To: <4C76B6CF.8040808@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154554>

Heya,

On Thu, Aug 26, 2010 at 13:47, Tomas Carnecky <tom@dbservice.com> wrote:
> Hm, so storing no longer needed branches outside of the refs/heads
> namespace (so that they don't show up in git branch) is a bad idea?

You can store them outside refs/heads just fine, as long as they're
somewhere under refs. For example, refs/attic/ would be perfectly
safe.

-- 
Cheers,

Sverre Rabbelier
