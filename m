From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: git send-email doesn't take To: addresses from the patch
Date: Thu, 2 Sep 2010 11:36:38 -0700
Message-ID: <AANLkTi=xQAoEFiB2zGz73ZwSwq16LOthkqd7w1GhnEup@mail.gmail.com>
References: <4C7B5853.7010001@st.com> <4C7E05B5.1050805@gmail.com> <4C7E1537.9030405@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 20:37:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrEej-0007yl-8H
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 20:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab0IBSgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 14:36:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40336 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab0IBSgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 14:36:54 -0400
Received: by wyb35 with SMTP id 35so18130wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=vqELkyORgYE2tIZU6u++HWcYX78ItHvm/Sy4hat4Pvk=;
        b=guZwFXC2FXRKw46kiGEaB3tAr+YzKIwYtCrDKziWLypIENu49GqqdkD5Hi3d0T8OG2
         WCLjEyoGtzZP3zlTqAV5kHwl7/OEBxpU2oB7lfprAgYtKYb5WCxSsbC9WKAyYEO2TAaV
         iU1YcWOJTFhYFTKS0t77evBLfnlklKsLyY4ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RCzx7tR6pYCiT78PwNktBVNBCZOYuaptzSrhbT8oaLqNy6m/qQwAj1h/be1JS0ILfH
         CndydRQWzX7SKlThX9GDVFryXtWylyAxZ5KIyuNcw2E3xDzLjd+q0oxoPV9nD4NKjzsW
         9uzWKZ1NLEO3dPV2bnVvrX/fxQVnAQTnsmw1Q=
Received: by 10.227.155.143 with SMTP id s15mr252650wbw.154.1283452613100;
 Thu, 02 Sep 2010 11:36:53 -0700 (PDT)
Received: by 10.227.131.208 with HTTP; Thu, 2 Sep 2010 11:36:38 -0700 (PDT)
In-Reply-To: <4C7E1537.9030405@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155156>

On Wed, Sep 1, 2010 at 1:56 AM, viresh kumar <viresh.kumar@st.com> wrote:
> On 9/1/2010 1:20 PM, Stephen Boyd wrote:
>> Subject: [PATCH] send-email: Use To: headers in patch files
>>
>> It's a minor annoyance when you take the painstaking time to setup To:
>> headers for each patch in a large series, and then go out to send the
>> series with git-send-email and watch git ignore the To: headers in the
>> patch files.
>>
>> Therefore, always add To: headers from a patch file to the To: headers
>> for that message. Keep the prompt for the blanket To: header so as to
>> not break scripts (and user expectations). This means even if a patch has a
>> To: header, git will prompt for the To: address. Otherwise, we'll need to
>> introduce interface breakage to either request the header for each patch
>> missing a To: header or default the header to whatever To: address is found
>> first (be it in a patch or from user input). Both of these options don't seem
>> very obvious/useful.
>>
>> Reported-by: viresh kumar<viresh.kumar@st.com>
>> Signed-off-by: Stephen Boyd<bebarino@gmail.com>
>
> Tested-by: Viresh Kumar <viresh.kumar@st.com>
>

Cool. Junio, does this look good to you? I can squash in some tests
later tonight if I get some git time.
