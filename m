From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-push.txt: mention about remote.*.push when no refspec
 is given
Date: Fri, 8 Mar 2013 17:58:54 +0700
Message-ID: <CACsJy8BNpMN3-Y1eZrJXpZp3-KU=kDN_4eM=87OD9d7yYYrHCg@mail.gmail.com>
References: <1362573848-21793-1-git-send-email-pclouds@gmail.com> <7v8v60qu2i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 11:59:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDv1k-0006WV-6P
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 11:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab3CHK70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 05:59:26 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:39792 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3CHK7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 05:59:25 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so1832621oag.15
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kT0IxX1Foc570rK/q3jYIuTMqmtKEqN4cIXani2SbRw=;
        b=JIzS0p/hC4D83u/ZKvVJ+S/qLCF1x/vzspqmgTSjL0AJHSZYmOmMpbHSuizc+re3rK
         b+iyn/rB2dTCnNVhvy+UdQ6C0Q0IgkHhdWl1IFC1Zyuxo5IUk6HvNaMs9ZOm54G4DEQ5
         nN1KfVybzv4t/YmF6bqZRdz5P1YD1hiraV53zvwkrqFKwcwh83u4N7+eZ/AWKOSjacRZ
         +HWnHhbOh++H6Gor+AMav5Ynx0k5EyIIShwG6E3TpOjYnzYBNNqRofcrjCbWqEJ8dRiN
         2dpkfUzPROoU1B52obhJDIBCgtBPA13sOEKqbNFeeosqHxC0zSigUvJVwTeA4JW5azB/
         D9OQ==
X-Received: by 10.60.30.231 with SMTP id v7mr1155394oeh.118.1362740364924;
 Fri, 08 Mar 2013 02:59:24 -0800 (PST)
Received: by 10.76.27.200 with HTTP; Fri, 8 Mar 2013 02:58:54 -0800 (PST)
In-Reply-To: <7v8v60qu2i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217660>

On Thu, Mar 7, 2013 at 1:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I agree that saying what it is, what it does or what it is for
> upfront (i.e. "Specifies what are pushed") before how it is spelled
> is an improvement.  I however think describing "If not specified"
> here was a mistake, and you are making it worse by burying the
> description of what happens when <refspec>... are missing in the
> middle of the description for <refspec>...
>
> I would rather see this done in the direction the attached "how
> about doing it this way" patch illustrates.  The way how "where" and
> "what" are determined when the command line does not specify is the
> proparty of the entire command, not of an individual parameter.

I agree your patch looks better than mine. Put it on 'pu', perhaps?
-- 
Duy
