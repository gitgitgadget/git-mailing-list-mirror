From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Any command to simplify 'git fetch origin && git reset --hard origin/master'?
Date: Sat, 19 Jan 2008 17:04:43 +1100
Message-ID: <ee77f5c20801182204r53ae03c2mac6d8fde9c4b260a@mail.gmail.com>
References: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 07:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG6pR-0000w4-Vy
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 07:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbYASGEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 01:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbYASGEp
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 01:04:45 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:52857 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbYASGEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 01:04:44 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1105742rvb.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 22:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jrKBelD9dDpFTZDWK61p5wL8ORycFkv0N5yVvXsqCQg=;
        b=AUeizNjE8ItPSBjx60HYJTPT8Ldw7wjux0Pv1pkeXch6LqaXuWJkJAQrXlZtaKmXaooE9FZkataOpxOkg6fbm34+8kPvHq2634Z1SCxTY+GBuCpZgA4+K+4SbMVy7YDpTykMzmfKErSG0euzQ1xXYY0Ga0MvVJdJ4g0LEv2aSng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XTPuHeaONZWVLqsMFQLy5FtNkh6jMh1TB7hoE90GP/i8OcBrP5ivu/Ehi9NIBas1IhuPMObGNgqusYfrZRkUjwcZ0FWnTPDBKbxjY0X1SdD2tcUcpYs9UaOXg/Ql5UdSpzCW8CTkJU1EEoHFf/POH5JAYBZKXMdY6+Q/aJsaK2k=
Received: by 10.140.142.4 with SMTP id p4mr2931342rvd.261.1200722683192;
        Fri, 18 Jan 2008 22:04:43 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Fri, 18 Jan 2008 22:04:43 -0800 (PST)
In-Reply-To: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71080>

On Jan 19, 2008 4:22 PM, Ping Yin <pkufranky@gmail.com> wrote:
> I often encounter the case that the origin reposotory is rebased and i
> make sure i want to use the origin head as my master
> Now I have to do
> $ git fetch origin && git reset --hard origin/master

Use "git pull origin", which will do the fetch, and then merge it. If
you haven't made local changes, the merge will be a fast-forward and
so will get you an equivalent result.


Dave.
