From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] git reset --recover
Date: Tue, 4 Mar 2008 13:21:04 +0800
Message-ID: <46dff0320803032121v54612b40ke953348e86daf1f@mail.gmail.com>
References: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
	 <20080303170242.GA30361@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Charles Bailey" <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 06:21:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWPb1-0000EN-DH
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 06:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbYCDFVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 00:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYCDFVI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 00:21:08 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:16099 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbYCDFVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 00:21:07 -0500
Received: by an-out-0708.google.com with SMTP id d31so109129and.103
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 21:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y78ookme6sJbGAZnvwOiirmSmHywIXIRnlQ0iBNlT2k=;
        b=aPp1tPo9495hfKsDI780qrc2sXFIbgU9VKEf6WelA3qoIk7RFebbh3IFNjZcaJDTf5OyaSbrMiEcix3RwmGBRxMuDYHByiMPFYgeqoTnlKabXH6HjAmDZbZ1rccdqpmZFxGUrGZt2K47/RkHZnk7fS74xTKXGxExF4f/4ZTfqe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J8wweGdVMqJAFR9xkLLJsMC1NAHugzuq5NhFZqUh5D6i36TyASA/fPBTKRCGGG3CMk8Az2TQA82MFpWvdyri/y9DH1usL58zaxuzIxa0A3lvCqLiBhejqVb/yEZ5KJHJH8LnFH1qmB2WF1M3ScQ/L7kxqyezEJ1QCQsqeFTf2vE=
Received: by 10.100.196.17 with SMTP id t17mr1377738anf.63.1204608064932;
        Mon, 03 Mar 2008 21:21:04 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Mon, 3 Mar 2008 21:21:04 -0800 (PST)
In-Reply-To: <20080303170242.GA30361@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76035>

On Tue, Mar 4, 2008 at 1:02 AM, Charles Bailey <charles@hashpling.org> wrote:
> On Mon, Mar 03, 2008 at 10:59:14PM +0800, Ping Yin wrote:
>  >
>
>  If they've been added to the index then the objects should be in your
>  git repository, it's just that it may be hard to find them.
>
>  Does 'git fsck' report some dangling blobs?  If so (some of) them
>  should be the content of your missing files.
>
Good news. So can "--recover" help me find the lost blobs?


-- 
Ping Yin
