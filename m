From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/24] t9300 (fast-import), series A: re-indent
Date: Fri, 24 Sep 2010 02:35:59 -0500
Message-ID: <20100924073559.GZ4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
 <20100924071631.GI4666@burratino>
 <AANLkTimjD6LqMgQSez=t9N_KPsXaFXm3sMcrZc=qQug+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2rz-0007DY-1U
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941Ab0IXHix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 03:38:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46929 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab0IXHiw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 03:38:52 -0400
Received: by yxp4 with SMTP id 4so861022yxp.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E7dBnqDGeyfIVcY7/FHgx6tH9AKhT01QYcS18fDbEqU=;
        b=twb0kART7bX0ixTBrnq+YdZ/5nnhzAJAu0Jg7kprx2QFCeG+U/2OeQF3sA+HJNCFwt
         3WbtaD6/Zga27A0urOATRFl4Ww5CRUROVvRIsMcPXILuVbse1c5mpYnDOHSVl9iuplN1
         gPwED+CxgNhHFfEC20JR+8xT0kYStSGVDXuWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ek+efCZoDeDGHWnQwnNRVRzCzRL5BRWCYLXLI96KPkk14v7lO5wAa6PnuDmnQd5W+f
         qFOF+Xz0f7QwWujVXFO9/vMaKa7sjh8S63PSWtA3aeNngeMfdVA0n3EvQNTzvsQ8DL5N
         IosGFCymwnwJCAZ+7fZw2dlzNOIr+RlCuUhxY=
Received: by 10.151.122.2 with SMTP id z2mr3851249ybm.435.1285313932111;
        Fri, 24 Sep 2010 00:38:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm761005yba.12.2010.09.24.00.38.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:38:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimjD6LqMgQSez=t9N_KPsXaFXm3sMcrZc=qQug+@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156961>

Sverre Rabbelier wrote:
> On Fri, Sep 24, 2010 at 09:16, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'series A: fo=
o bar baz' \
>
> Sometimes this style is used if the test description is otherwise too=
 long.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_expect_success 'series A: foo bar ba=
z' '
>
> So what do you do in the case that the line becomes too long?

In this series that never happens.

In general, either

 test_expect_success \
		'series A: foo bar baz' '
	... commands ...
 '

or

 test_expect_success \
	'series A: foo bar baz' '
	... commands ...
 '

looks fine to me for those cases where no shorter test description
comes quickly to mind.
