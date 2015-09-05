From: Jesse Hopkins <jesse.hops@gmail.com>
Subject: Re: determine name of tag used for checkout when multiple tags exist?
Date: Sat, 5 Sep 2015 08:23:03 -0600
Message-ID: <CAL3By-9e2ZjShFxMKoLfc_q0LFvB51m15Z8Ydp8b8fGNdcUp_A@mail.gmail.com>
References: <CAL3By-8odLE53iBiNATgiCcnK4Ef5uBeH7E6EMB1K7P-oX0oAQ@mail.gmail.com>
	<20150904075400.GA27660@serenity.lan>
	<CAL3By-8ieAQPyR9k63_T5Fa9ZnAY8qSNZUpr_=fxebEcN=Zi7g@mail.gmail.com>
	<CAL3By-8cgAz1Jau3NO0kkHAVwvy3hPMMUn=xwUtY78TE5WE9vw@mail.gmail.com>
	<20150904111915.GB27660@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Sep 05 16:23:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYEN3-00070l-QF
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 16:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbbIEOXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 10:23:06 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33604 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbIEOXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 10:23:04 -0400
Received: by oixx17 with SMTP id x17so25704920oix.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+NzvHWPzxacFPQ0S/BSSMnxXcU40+iOq4XyvxzEn5i0=;
        b=CoUZWl/7jq0c1+2xuiqWdT/vesJprQiGn8PB+Dzkx6+dKBL5ccCTtCLHYic15v5xq2
         hVHxTg1nsgoLUX+h0Rzz6N/AT5ENdyuW0z6kpIkXCxT2oDmbrI4jzfHgzxvnV0IP5KQO
         ZxuMqQpjQzJ5mEtz1hg6ZsAPf1CRLhjHd8DzEuw6cZqND0u8eNS46UDo5NPLtXPk70Zn
         sh7CVHtX3Wv6JXe4PRMAIFOcmSLkU4iKhtxh3k6ScqCeHSSf5VXZIZaMFHN+VF16trSG
         rRlES34R1o+5MfiwQGtV50nmUMtwkFl9eM5MrPBRlQuj81thzX0OM2Z1nuTYEi2U83h9
         Dazg==
X-Received: by 10.202.204.208 with SMTP id c199mr7437767oig.12.1441462983139;
 Sat, 05 Sep 2015 07:23:03 -0700 (PDT)
Received: by 10.202.1.199 with HTTP; Sat, 5 Sep 2015 07:23:03 -0700 (PDT)
In-Reply-To: <20150904111915.GB27660@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277383>

On Fri, Sep 4, 2015 at 5:19 AM, John Keeping <john@keeping.me.uk> wrote:

> I think it would be a reasonable enhancement to include the branch name
> in the reflog message if "-b" is given to "git clone", but I'm not aware
> of any (formal) policy on the format of reflog messages so relying on
> any particular message may not be 100% reliable across Git upgrades.


Thanks for posting my dropped message.  Apparently the gmail Android
app doesn't do plain text.  I understand that parsing the reflog
message may not be future-proof, but I'm going to go for it.  I think
that will be more reliable than trying to track the tag name
externally.  Having the reflog message show up for a "-b" clone would
be helpful, but it will be easy enough for me to clone HEAD, then
immediately checkout the tag of interest.  Thanks again for the
suggestion, would've never thought use the reflog.
