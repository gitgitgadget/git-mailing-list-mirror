From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 3/3] travis-ci: run Git bisect on failed tests
Date: Mon, 23 May 2016 10:36:19 +0200
Message-ID: <BCC937A6-27E4-4849-80C7-82EC155F08C1@gmail.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com> <1463914856-64745-4-git-send-email-larsxschneider@gmail.com> <CAFZEwPOuCRJFx0wH5YHKxWNmjkvi2R6s5G0Bw+WrnHywT3cR0g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 10:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4lLf-0006TY-3u
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 10:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbcEWIgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 04:36:23 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35537 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbcEWIgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 04:36:22 -0400
Received: by mail-wm0-f45.google.com with SMTP id a136so9127074wme.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 01:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DNsr8beP6pl1PRVD21BI6aT4IEn+czgl4X0kzc6++to=;
        b=T/luVIDS3b58P1IpBSnsalP1riQqfRA2VkNIiQMp3soB1TRC7GqBrd8fEfbxMCgo7S
         2799d9KNFe0bLOwWIfQOCBcHEKEyj7r8hIrPGIwhKJ90CrLuumJSys2wEAPJkQQHn30a
         +27SURSV4BRIdgdZ2nGOExA78kqy5UemLW78h5lBrhOyRUsmYvLi3AvzagFRGWAon1jJ
         gi3DdsWzrJ2nGVEgsXCyqFcCxStzBmkoifsfCrL3h0U64b43s9za1BtVkSJw4uGvcEl9
         wnAcJ9hKhLhCcQP7u44g1DlIPAmB6JpMy0z9EUl+TXnc5suXMnApXNVeT+b6YWFQCTbU
         vZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DNsr8beP6pl1PRVD21BI6aT4IEn+czgl4X0kzc6++to=;
        b=L+6yQxd40J26TLAylPadwW/cj10SL6/J5qakyKNBSWX8iK9tyNvLg8af6DQek5eQhr
         zzOo1Jr2nF0itJSYpjMpnGiWKH7ga4hcU0hdbYyrkqBPyMrCVX4y9Vww9I/iV3GO9DL8
         OB0lwNnErr4IlBGmK2U4um4Tsg4CwwSzvKijliuidsQZD26VWWEUa0X36jG+bG9ma5+/
         L4kg6v/m4l9a4sIf2YlbrrQ4jE6vO1Ce7oPVUvopzRILE7Xem+glsaNHCTMAaStlyqBG
         UTOVLFCplwc24GU/LcVsVY7ctgmbmX4Hm5Dw0XTN/pK8jq7dNHjfgV0qDt8z3D/AU/jX
         dOFQ==
X-Gm-Message-State: AOPr4FXUGY2c9akGA1KAUPblic1fQZC+wa3+aOTnWArKNUaPfxd190hTVAJ/oPGyhNHtDw==
X-Received: by 10.194.192.106 with SMTP id hf10mr15548859wjc.52.1463992581211;
        Mon, 23 May 2016 01:36:21 -0700 (PDT)
Received: from remc1rbk32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id f8sm34063768wjm.13.2016.05.23.01.36.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 01:36:20 -0700 (PDT)
In-Reply-To: <CAFZEwPOuCRJFx0wH5YHKxWNmjkvi2R6s5G0Bw+WrnHywT3cR0g@mail.gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295312>


> On 22 May 2016, at 19:21, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> 
> Hey Lars,
> 
> On Sun, May 22, 2016 at 4:30 PM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
...
>> +
>> +#
>> +# Run Git bisect
>> +#
>> +run_bisect () {
>> +       TEST_SCRIPT=$1
>> +       BAD_REV=$2
>> +       GOOD_RV=$3
>> +       TMPDIR=$(mktemp -d -t "ci-report-bisect-XXXXXX" 2>/dev/null)
>> +       cat > "$TMPDIR/bisect-run.sh" <<EOF
> 
> If you are doing a re-roll, then you could probably fix the style issue.
> ' cat >"$TMPDIR..."  '

Good eye :-) I will fix this, too.

Thank you,
Lars
