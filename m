From: Stefan Beller <sbeller@google.com>
Subject: Re: Dependency Management
Date: Tue, 23 Jun 2015 10:34:44 -0700
Message-ID: <CAGZ79kZkUvqDzf-j0Z3yM5q+spV-MFYL5da4LOrYoGOHFsftjw@mail.gmail.com>
References: <45DF444C03B59343B5893402DC4F867E3A800EC7@PB2OAEXM01.oad.exch.int>
	<45DF444C03B59343B5893402DC4F867E3A800EF8@PB2OAEXM01.oad.exch.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jean Audibert <jaudibert@euronext.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:34:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7S5z-0002zj-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbbFWReq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:34:46 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36448 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbFWRep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 13:34:45 -0400
Received: by ykdr198 with SMTP id r198so9563653ykd.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UOKubd5XATnbR4nVT2iAh6v4EIxZDvnB4DELP0GfmVE=;
        b=S0R0ln/Qc7EEhsGK4TSPUCiNGOdWkE9Zuy3VddhAacwLvQvvaLvJFvjUomsO4CBo0J
         Y9WcP5rLh1q8qJ5KJQrwCVqucg2sGIBnDrV03A6bRbnchnkQKxGSnwNILSiYdSlwkAmt
         l+qVtRaTo14/iLqjEZGdxeiXlI4DMMHmups/0KFD3LwqG1cgELseCbm1fgp2mUJ3Xqv1
         KjTE2mPc2JlKmLkUq+KV49/JeQ1EeJ13+/n7qgWupT0AMNPj4oUxdvm2RdAdG+VbHSSI
         jlU2FIvS0buTalEubtO+10nEekE1K3Df80MpPDwWBPNtZjkv8t/rX9xe3n1mXr/gi0ij
         cJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UOKubd5XATnbR4nVT2iAh6v4EIxZDvnB4DELP0GfmVE=;
        b=daOJEZwCyRCjJopApV1RCm0tO6Uyol/lasXgI+3xXlONHhC0QX8PBORsp69LxOHiCW
         bSnjrXDbS/8+kwVBsM4wHTt/nryxpF4pkjqW1O5NMUF+4G/eH6IBR/fPhmY3dZiEwMIa
         VGmQD+j1ZKmOS1fW0KoyQ+EqeU6IGz4TFXxlKOTfFemNPLP8xlSEC7/552f+NM+akPPo
         LBYn4O35kJuvG+QpEwOSgO14LqqPObvbhvQnFjvlnfFLdzsiLxTtpVIU7+/6VRsfnMJd
         72fl7FkG8Mmm/tJUg926ayL0alSRlOHx5F68KsTrGe5NZeJNoFKNYhR10YLVok33md93
         AJVg==
X-Gm-Message-State: ALoCoQn7+tJ9UZF8MMqVeRvStektCJuomd8/WnCzZeRC7RwwejfjVHTCwoylnZZx+rjMg9CGPQPz
X-Received: by 10.170.217.85 with SMTP id j82mr20478074ykf.25.1435080884947;
 Tue, 23 Jun 2015 10:34:44 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Tue, 23 Jun 2015 10:34:44 -0700 (PDT)
In-Reply-To: <45DF444C03B59343B5893402DC4F867E3A800EF8@PB2OAEXM01.oad.exch.int>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272470>

On Tue, Jun 23, 2015 at 1:52 AM, Jean Audibert <jaudibert@euronext.com> wrote:
> Hi,
>
> Sorry to bother you with this question but I can't find any "official" answer or "strong opinion" from Git community.
>
> In my company we recently started to use Git and we wonder how to share code and manage dependencies with Git?
> Use case: in project P we need to include lib-a and lib-b (libraries shared by several projects)
>
> In your opinion, what is the "future proof" solution?
> * Use submodule
> * Use subtree
>
> We know there is lot of PRO/CONS but I feel that subtree is "behind" in the race and the latest version of submodule work fine

Use whatever works fine for your use case.

My personal opinion/expectation is to see submodules
improving/advancing more than subtrees advancing in the near future.
Though this is neither the official nor a strong opinion.

Stefan

>
> Suggestions are very welcome.
> Thanks in advance,
>
> Jean Audibert
>
>
> _________________________________________________________________
>
> This message may contain confidential information and is intended for specific recipients unless explicitly noted otherwise. If you have reason to believe you are not an intended recipient of this message, please delete it and notify the sender. This message may not represent the opinion of Euronext N.V. or any of its subsidiaries or affiliates, and does not constitute a contract or guarantee. Unencrypted electronic mail is not secure and the recipient of this message is expected to provide safeguards from viruses and pursue alternate means of communication where privacy or a binding message is desired.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
