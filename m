From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Bug] git show crashes with deepened shallow clone
Date: Wed, 25 Sep 2013 11:48:51 -0700
Message-ID: <20130925184851.GX9464@google.com>
References: <5242F78C.5060607@atlas-elektronik.com>
 <524300FF.5000801@atlas-elektronik.com>
 <loom.20130925T200459-360@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 20:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOu8z-0003gx-JB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 20:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab3IYSs5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 14:48:57 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:56733 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab3IYSsz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 14:48:55 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so221884pab.32
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o0jc4VCF/t4G52Gix4ATA6MpvPPnkSBzX4+YF+q7ujw=;
        b=s7lOlxy1jbstQ2bmxPkSPxj0Y5D2MXy3IMKS1xyUDMlBeH7/XSIiTkUM4JaKEQ2Cnc
         UBQupZKlGft+F36gJd/MuVdjrXCWBGuvTTSFqJOrdmG3vx4Pwn4aNUnDRKl1crgezQaU
         8nSrDmcgYsKCHlsev1nh2eymEdneu0/EW7GjDr4oYgAmw5euEZmyhwkVBIiIO/3Abs0O
         iZ4CjqnBiGwJ1sx2+w4PueeFKkYHNVcjj1459UW/VQR6vHvk6xvexihaWAwwhd1pjr+o
         MmpqnCwEXRJpFVIwT8AKAX3Z7KjhaGQtxnGBUxpJKYgxC/mLuxY9shjQvrRLPLLIBkxX
         vJbA==
X-Received: by 10.66.25.133 with SMTP id c5mr898380pag.4.1380134935236;
        Wed, 25 Sep 2013 11:48:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 7sm55204373paf.22.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 11:48:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20130925T200459-360@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235363>

Stefan N=E4we wrote:
> Stefan N=E4we <stefan.naewe <at> atlas-elektronik.com> writes:

>> 6035d6aad8ca11954c0d7821f6f3e7c047039c8f is the first bad commit
>
> And to answer myself once more:
>
> That's fixed in
>
>    6da8bdc fetch-pack: do not remove .git/shallow file when --depth i=
s not specified"
>
> Sorry for all the noise.

No problem.

It's probably worth releasing 1.8.4.1 soon.  Thanks for a reminder.
