From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Wed, 11 Aug 2010 01:04:08 +0300
Message-ID: <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
References: <4C5F9B25.8080401@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: viresh kumar <viresh.kumar@st.com>, git@vger.kernel.org
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Wed Aug 11 00:04:38 2010
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from bombadil.infradead.org ([18.85.46.34])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1Oiww1-0002I6-Pu
	for linux-arm-kernel@m.gmane.org; Wed, 11 Aug 2010 00:04:37 +0200
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Oiwvd-0004Tg-3c; Tue, 10 Aug 2010 22:04:13 +0000
Received: from mail-bw0-f49.google.com ([209.85.214.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Oiwva-0004T8-3q for linux-arm-kernel@lists.infradead.org;
	Tue, 10 Aug 2010 22:04:10 +0000
Received: by bwz19 with SMTP id 19so3074578bwz.36
	for <linux-arm-kernel@lists.infradead.org>;
	Tue, 10 Aug 2010 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:received:in-reply-to
	:references:date:message-id:subject:from:to:cc:content-type;
	bh=DL/cN1HP5uZXG++2iJqdtZQmAQwCLJCyH/ous4Y1stQ=;
	b=bQFUWGtXST0YPsd46exCjzt5KBPUlH4+w+4MKsT9Xzrj0Q18GKBz9vlfmq6ebk9SFC
	y410uhnaWO4IozD5TNjXLKh09UxZSsBHuTsLq0D0mYWz/TFjfCz5183B9Dg5Ycd0aYJc
	wPawOx2WMW85IsoBU+Gys4QrJfA6GE3smHbbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	b=cwVF1C8PhyVQ7WWMqFlwdJlwZDmeGi749tKKxPvQ/Pd7lIdUWoPee2rsHm4JbK8lz3
	/JY0JpLiOkAj7lwv5pEAnw4Fxpx4Xs5BAHEaCLk4bU4YU+Bw4HkQ/6q9LlzlE63Zb5QE
	ajoh4h2nbniEoQwgKu9nWpwEdfWVSYs8jxAuY=
Received: by 10.204.35.5 with SMTP id n5mr4581465bkd.155.1281477848294; Tue, 
	10 Aug 2010 15:04:08 -0700 (PDT)
Received: by 10.204.122.143 with HTTP; Tue, 10 Aug 2010 15:04:08 -0700 (PDT)
In-Reply-To: <4C5F9B25.8080401@st.com>
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20100810_180410_294977_0659748D 
X-CRM114-Status: GOOD (  14.58  )
X-Spam-Score: -0.1 (/)
X-Spam-Report: SpamAssassin version 3.3.1 on bombadil.infradead.org summary:
	Content analysis details:   (-0.1 points)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	-0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at http://www.dnswl.org/,
	low trust [209.85.214.49 listed in list.dnswl.org]
	0.0 FREEMAIL_FROM          Sender email is freemail
	(felipe.contreras[at]gmail.com)
	-0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	author's domain
	0.1 DKIM_SIGNED            Message has a DKIM or DK signature,
	not necessarily valid
	-0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153162>

On Mon, Aug 9, 2010 at 9:07 AM, viresh kumar <viresh.kumar@st.com> wrote:
> Mail server in ST has recently changed and now we have Microsoft
> exchange server. We are using thunderbird as mail client.
> What we observed with this server is that patch are broken now while
> sending as well as receiving. Tabs are replaced by spaces and may
> be some other too which we haven't observed.
>
> Has anybody found a solution to this kind of issues? Are there any
> workarounds possible?

Same in Nokia. I wrote a script to fix exchange's crap, but I also
noticed some quoted-printable mails didn't get converted, so the
easiest would be to tell git to always send quoted-printable.

git folks: any chance of getting that feature to git send-email?

-- 
Felipe Contreras
