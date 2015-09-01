From: Stefan Beller <sbeller@google.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 1 Sep 2015 10:56:03 -0700
Message-ID: <CAGZ79ka4+a_eyha=xCrQFBdLzgbT3ws1Jq7Q=WJw45Ob6bFFug@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
	<20150831102558.1514e5f7@anarchist.wooz.org>
	<20150901092834.GA10706@gmail.com>
	<20150901101924.6c350012@anarchist.wooz.org>
	<xmqq37yyt7k8.fsf@gitster.mtv.corp.google.com>
	<20150901135018.70240193@limelight.wooz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Graeme Geldenhuys <graemeg@gmail.com>
To: Barry Warsaw <barry@python.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpn1-0003cO-8t
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbbIAR4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 13:56:06 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35963 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbIAR4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:56:04 -0400
Received: by qkbp67 with SMTP id p67so52352135qkb.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x7yXRPyHl8zAMRZZtQvZ9lmdQT/C0CD9yc4YwAYXZ7g=;
        b=gRQeqQc1RWRu4xTUuqL1mA0fBsOMSsAWc4MsR0zjX1kFFb/UwQsBSg7bnCzd/BK8QV
         mEH+w7XywIDTze3oZvQANmB9QmvYAP9+nAatISdLR3vlCoPmWDIltGbEWUlfrivED6CY
         uYdrIiOldfzPrcozuygF9vIgvz+PC6IYjGIDnoKBbkbhh02LjQf/wSBrLz8ALyxRYEaM
         rn0X431x7A1s27ZYhv7oLTzZKsRCRyrSsPHj+55yWoQnz/4SEDw5CnhDuTX+L3CtK7G4
         NXFosovrpVA0K+ei5NmMf4ESXm+N8mfiYtB5p6JEEVK0OPbPDQ9bm0ZtkY4BiCp++EzO
         o7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=x7yXRPyHl8zAMRZZtQvZ9lmdQT/C0CD9yc4YwAYXZ7g=;
        b=KN51iZo/T+OtLMA3Y2dWWJ9FealsXuuu/HCN7zEIw62xBYojOPbP1fObIY7iT268AV
         +U0QDahShchnE7KdYl6TyF3i6AiMYgqQrYywz0FOs7kCus3qJ7g0q0/+n9kHhWaWYBl/
         3DKki+KfPcpv5QPnXIOfqW1CyOY0Gt3zpLDx59NFYRsU9WlvNxPxwvsQd7dld+J5izVH
         13G0SEwMVl/QAmT2idAnwXJXCtSsJBdZXmlv42REBKdOmp9yxsu3ZWqp930hDLlrYIUv
         EzfGFLlYbZ9aSfwWz55JIJcTq7+B2or/OZD266sjAaEE96odjKE62IIhx9FZWmyo5vzz
         1VFw==
X-Gm-Message-State: ALoCoQnD+Toej24VHhCcO1O26BlEhlFQRHRpwrjopCLTVWP0F3kgjJ+zQN1E18mf66LcT0Ysy3Xp
X-Received: by 10.13.218.131 with SMTP id c125mr29769602ywe.129.1441130163242;
 Tue, 01 Sep 2015 10:56:03 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Tue, 1 Sep 2015 10:56:03 -0700 (PDT)
In-Reply-To: <20150901135018.70240193@limelight.wooz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277004>

On Tue, Sep 1, 2015 at 10:50 AM, Barry Warsaw <barry@python.org> wrote:
> On Sep 01, 2015, at 09:42 AM, Junio C Hamano wrote:
>
>>That way, you are forcing all the existing scripts to be updated to
>>say "git -c ..." for _all_ invocations of Git they have, aren't you?
>
> No, why?  If the default value enables the current ui, then no scripts need
> changing.  Users can enable the new ui for their own benefit at their own
> pace.  If you eventually want to make the new ui the default, provide a
> sufficient transition period.
>
> Cheers,
> -Barry

So say I am a user who wants to take the new command set. And as I am lazy to
type it all the time I just do:

  $ git config --global command-version 2

Now I have all the new fancy stuff when I type it directly into the terminal.
But when I run one of the old scripts my coworker gave me (which is used to
the old notion), it must adhere to the old command world. How do you now figure
out if this is interactive or script?
