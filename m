Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E2C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 11:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiFFLhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiFFLhg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 07:37:36 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E1245B2
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 04:37:32 -0700 (PDT)
Date:   Mon, 06 Jun 2022 11:37:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail3; t=1654515447; x=1654774647;
        bh=K0c3B1saB+oIODQMieXaBuyRAXDIBtimIe1CuEpuhok=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=WJhICqygQ4PpsgnxdvD6aqbFFalMEXG/VgHZoHcPglZCQQSLyCZ/Vbmp9y8kgajvV
         Bul0cn1nLvwaVpp+nwYAu5VWbciV7RgC66GQsmUD6ieJwq5u/3lDyxI2rhK4F4Jf97
         tb7lWNOl5O8lLqe+g1mOZtkE271ViQKziA2ErjiQuFRFI9d2C9o8stkkyseTKgXaVK
         3WKG7tw4dsbnWniDFE1CKRKdnDszhcxfDqJvfdNwWUvzkThV5ck04p9pEYMkQecSqy
         +rRAJ/tglCSSJO/kxyYSiSCOvlwbcWeQ1LLMvHjRDrRIQ/01ja+00eZsJcd5RjYhbX
         NIUYjfz00ZH6Q==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Laura Smith <n5d9xq3ti233xiyif2vp@protonmail.ch>
Reply-To: Laura Smith <n5d9xq3ti233xiyif2vp@protonmail.ch>
Subject: git-config  gpg.program - more flexibility needed ?
Message-ID: <cVbMAjbLsxZPKlRxZe1zSKBcPx60ss_U_7r5ew78Dv3TVnCTMoisvnDgQXAh-2i4Li41Id6TAsO-rpc4DBIN41lMMIzhGIYxcQcfJ2eBM8Q=@protonmail.ch>
Feedback-ID: 9341368:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_nqcLT3B1AwlQM4Dqm9DyqSnszdzZI19nbOv23aUWNc"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

--b1_nqcLT3B1AwlQM4Dqm9DyqSnszdzZI19nbOv23aUWNc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

If my understanding is correct, gpg.program (https://git-scm.com/docs/git-c=
onfig#Documentation/git-config.txt-gpgprogram) is a bit too hard-coded ?

There are excellent non-gpg CLI programs out there such as gosop, sequoia a=
nd sequoia-sop.

It would be great if instead of hard-coding the required flags that git req=
uires, users were given the option to override the flags.
--b1_nqcLT3B1AwlQM4Dqm9DyqSnszdzZI19nbOv23aUWNc
Content-Type: application/pgp-keys; name="publickey - n5d9xq3ti233xiyif2vp@protonmail.ch - 0x94FAF468.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - n5d9xq3ti233xiyif2vp@protonmail.ch - 0x94FAF468.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeGpNRVhSek1IaFlK
S3dZQkJBSGFSdzhCQVFkQW8wbTFYeFpsWEZDcWt5NTJiWDNXNnpIUlI0dkdXVU9TDQpBRUpMdEpO
dkh2bk5SMjQxWkRsNGNUTjBhVEl6TTNocGVXbG1Nblp3UUhCeWIzUnZibTFoYVd3dVkyZ2cNClBH
NDFaRGw0Y1ROMGFUSXpNM2hwZVdsbU1uWndRSEJ5YjNSdmJtMWhhV3d1WTJnK3duY0VFQllLQUI4
Rg0KQWwwY3pCNEdDd2tIQ0FNQ0JCVUlDZ0lERmdJQkFoa0JBaHNEQWg0QkFBb0pFTlg3M0tLeWFS
V1Y4MklCDQpBT2N1K3FYaGo5RW15SUxVYzZUZlY4Y1A4SHpnQTVmaVhrZVAvQ2I5c3E1T0FRQ1Bz
ZjRmZW5BUDgyZ2UNCjlLdS9zTVRhN05tTW92eGxrV2VGYXBXOXRoUGFDTTQ0QkYwY3pCNFNDaXNH
QVFRQmwxVUJCUUVCQjBBdg0KTjN1UFZlNCttbmc1UkZsaXhwSzhkSGpjeEJUQ2J4QUhJVGJvcnlt
K2NBTUJDQWZDWVFRWUZnZ0FDUVVDDQpYUnpNSGdJYkRBQUtDUkRWKzl5aXNta1ZsWCtLQVFEWStm
YWtnLzJLaWVUNXN3V2VzbE5VSmNLOTBpeDMNCkl3R3g1ZTFTUEtnL2ZBRCtQak5mdWVWVGZRSlkr
NzdXYWZHWWpSNC9LRHBIa1l3M01xa20rYTgvMUF3PQ0KPWRBRWoNCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0NCg==

--b1_nqcLT3B1AwlQM4Dqm9DyqSnszdzZI19nbOv23aUWNc--

