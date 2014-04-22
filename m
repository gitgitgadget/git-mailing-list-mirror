From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 11:31:41 -0500
Message-ID: <5356996d12ede_3e5aed7308e5@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <53558f6269f91_640076f2f08f@nysa.notmuch>
 <857g6h5ssh.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 18:42:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcdlr-0006rU-Sw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 18:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbaDVQmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 12:42:05 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:61458 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbaDVQmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 12:42:04 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so5975207oag.11
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=TotUdqzIhffq90dMTGNFH9jDv44Na8O9/5Z2FpEggoI=;
        b=O3E4jeqsbV4H5mXXzeIX1uDh+g1OzozCoKSi6pAS47BoCF49lV4O393EIrvP7q8cu6
         +ijQ1vTwMXd49YkY3r+h3np/tlffuKNjS7gjEMZ0MUwPV52EdZsJTmaZ9ZjwiyJqoMTS
         EP081Ql9zM55DuQrxSkDHZcZcJXyZpXix/y9G+vgGNhuR3L0EV5Wu4U/Y3nZ6hDFVlVI
         8uqqBYP419DUJL38XB3ExlNI6zmdPni+8Way8zrtm8CeoQIzJ0PV59MCmETeJwoJb/lm
         79H02hkJE8Sjo4qG7VEpFBsC9AePT6AtsmCp8CQWdPnHutTQClBCUYStLbOxfjBT4s+E
         Uy1w==
X-Received: by 10.60.115.68 with SMTP id jm4mr2765657oeb.57.1398184923181;
        Tue, 22 Apr 2014 09:42:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm179715418oek.12.2014.04.22.09.42.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 09:42:02 -0700 (PDT)
In-Reply-To: <857g6h5ssh.fsf@stephe-leake.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246750>

Stephen Leake wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Ilya Bobyr wrote:
> >> On 4/21/2014 2:17 PM, Felipe Contreras wrote:
> >> > Ilya Bobyr wrote:
> >> >
> >> >> Also, most have names that start with either "pre-" or "post-".
> >> >> It seems reasonable for both "pre-update-branch" and
> >> >> "post-update-branch" to exist.
> >> > I don't see what would be the point in that.
> >> 
> >> Do you see the point in the other hooks doing that?
> >
> > Yes, there a reason for the existance of those hooks. Now tell me why would
> > anybody use post-update-branch instead of pre-update-branch?
> 
> I have a branch which should always be recompiled on update;
> post-update-branch would be a good place for that.

And why would pre-update-branch not serve that purpose?

-- 
Felipe Contreras
