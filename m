From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 2/2] gitk: Fix the geometry when restoring from zoomed 
	state
Date: Thu, 17 Sep 2009 17:04:27 +0400
Message-ID: <e2480c70909170604j7f5f1bf3wc1c42eb62430126d@mail.gmail.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	 <8763bkcsxb.fsf@users.sourceforge.net>
	 <19122.10359.725107.949551@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoGkB-0004yf-QV
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649AbZIQNJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 09:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbZIQNJj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:09:39 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50527 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758464AbZIQNJi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 09:09:38 -0400
Received: by fxm17 with SMTP id 17so7098fxm.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zUVEJqIQMVdmVJ2VYzj5UJhk6l1CZQ3fV+nbIkSr4rY=;
        b=DGAN0aDa8G7kDWC6JfQ29K7lfilL5WJk7ysDAW1j3+sqq67OMl/ntaiKf6pFKdqJG4
         tPCgQJK8ehQ50W2nfUXF15Z9zkWlFxLAw9quiSwyIgQyT4zl/DM505yzu28oTkoZnqQA
         Lc5yk7xV/pIbBnHM8TDysAEAb8tq/wv1n0zyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w6wBkDoa5XhWrEbuBMGX7P1HhuqJM8OSgH0W8y93b1NDE8nndTeIamGtXGLfi2lHY9
         eivqT7qEffBJSei11+UDP2TOxMgkcdhf+1hgoaYWDfga5ZRf+9qR10TCUTZbBGMh/BHV
         1WWyMvG6hMCEKrfLMXJTxIku8i/ST6prD6NWM=
Received: by 10.223.4.23 with SMTP id 23mr8064fap.91.1253192667130; Thu, 17 
	Sep 2009 06:04:27 -0700 (PDT)
In-Reply-To: <19122.10359.725107.949551@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128753>

On Thu, Sep 17, 2009 at 4:15 PM, Paul Mackerras <paulus@samba.org> wrot=
e:
>> The patch to handle the geometry of a restored gitk by Alexy Borzenk=
ov
>> causes the position of the columns to creep each time the applicatio=
n
>> is restarted. =C2=A0This patch addresses this by remembering the app=
lication
>> geometry for the normal state and saving that regardless of the actu=
al
>> state when the application is closed.
>
> So this patch replaces Alexey's patch, then? =C2=A0The context in you=
r patch
> doesn't match the changes made in Alexey's patch AFAICS.

Yes. Pat's patch replaces my patch.
