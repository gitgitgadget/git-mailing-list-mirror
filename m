From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/4] update-hook: show the contents of the tag message for annotated tags
Date: Tue, 20 Mar 2007 15:27:11 +0000
Message-ID: <200703201527.15476.andyparkins@gmail.com>
References: <200703201058.38519.andyparkins@gmail.com> <20070320124154.GB22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 16:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTgF9-0000u5-Na
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 16:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933795AbXCTP1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 11:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933675AbXCTP1V
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 11:27:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:21727 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933795AbXCTP1U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:20 -0400
Received: by nf-out-0910.google.com with SMTP id o25so411213nfa
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 08:27:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FImHyadmvRVRblqtx0c2C5FX/mHszjHCOn9OS9PlmmV5h3I7SPgaWKHfHKp9jz6Fh7UMYXWJh4IdrXobEPM1npchb3x0NgT2E7rSKgYPv6xnbEbzOzP12nwVsspUuMQEn3czYoOMQEGV503FqmeDQtLaTHp3CpLKVsyJOaXOvco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hcZs28Ygx/6yQFljE7gimv3rBn+RfbBbeJPcXgpiucnj+GexUU/kVgiVjJ7a8IK0z28X2JRH8V2lt5vuppjliUZ2rD6pVPGJCBE4eVSTBv7Sj5pWGgl1XIH3bIerQnWlJGAeCz6QMldAqJYbmjNnSEPmFUVA5kGBUKqRCwJQNAE=
Received: by 10.78.18.3 with SMTP id 3mr3140980hur.1174404438376;
        Tue, 20 Mar 2007 08:27:18 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id l21sm2402333nfc.2007.03.20.08.27.17;
        Tue, 20 Mar 2007 08:27:17 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20070320124154.GB22773@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42746>

On Tuesday 2007 March 20 12:41, Martin Waitz wrote:

> > Which is dangerously reliant on the format of the tag object being four
> > header lines then the message.
>
> I think you can split at the blank line after the header.

That's a good idea; I can't think of an efficient way of doing that in shell 
script though.  What I need is a 

 grep --everything-after "^$"

:-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
