From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 08:43:50 +0000
Message-ID: <200703200843.51473.andyparkins@gmail.com>
References: <1174361424.3143.42.camel@dv> <1174367312.3143.75.camel@dv> <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pavel Roskin <proski@gnu.org>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 09:44:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTZx5-0006fQ-Hy
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 09:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbXCTIoC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 04:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbXCTIoC
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 04:44:02 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:9800 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbXCTIoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 04:44:00 -0400
Received: by nf-out-0910.google.com with SMTP id o25so253995nfa
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 01:43:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l5YZruwLGQ6z3OnPdztDlq9/xYWI2FNGOaeGmjMiJIaHZSjLL6Lrk/58yJld3FyeF0umjcNzIyyB4Vgsh9hSa5HEzw4gZkwlNm3UN8NINs6ArZ85epqW8J8UrQU6h4Im9v1gn7BHSFgJb2d8WalpdKgRnpc7t/lyLkjBCr3q2R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B8N2YXljiICv1CACa73kjnkavZNsRIjtauECr/e0H8m7jcYGQMIDmYPyffLdJ2FKf4tkfn/2QTKEY5NZWbCDnnSWSPtAUcDB/h7BvaEHZGIuJ/ZYivdBCwXs4fxTO3G2Nc8otXWSHD2H0uvDnZ5lN1r1Rif+8u0U4MtMJZmzhek=
Received: by 10.78.138.14 with SMTP id l14mr2902597hud.1174380238737;
        Tue, 20 Mar 2007 01:43:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id p45sm1168295nfa.2007.03.20.01.43.54;
        Tue, 20 Mar 2007 01:43:55 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42729>

On Tuesday 2007 March 20 05:41, Linus Torvalds wrote:

> 	[core]
> 		legacyheaders = false
> noticed, because almost nobody uses it.

I'm not sure that's going to be true for long - the 1.5.0 release notes 
recommended setting it (assuming you didn't need backward compatibility) - 
which is exactly what I (and I'm sure others) did.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
