Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2660C1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 00:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbeDYAcQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 20:32:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55916 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDYAcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 20:32:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8so4228656wmg.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 17:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=4IdJ4X/8P8A8A2jAcK7p5LV0OhMIrbBHMCqJ9U5AZtk=;
        b=G8ShmCjlsOFsBNYHmfNGIqjq5rZE3go9O7yA0x5mVXBCHXCp5JCK/AUXy7qIaCuY2U
         ptm7p18gisggg04jVVW9VPbNDWxS+6VdneBRmdHtcYlD7oheiO/QplmYaVJDMGUqbkMa
         2NqcHwEDmba4+dmyy0bPegYvFJBzjuBF5XTZMrPB6Oi/qAQuutRd54hsUvbG6emMdidw
         mhfq/GxPbK7jNEPwgFrskiIjW8BTdQ+3mj0HLB6C+m+lw6JI4HnTyI3ESShtC4EVc9M2
         0FhPmfvMzVShqMRPTWDWVi0cZS8/x2MEEx/rWI2UGU6SewNB613oZ5jNOn/deQ+c2fov
         6+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=4IdJ4X/8P8A8A2jAcK7p5LV0OhMIrbBHMCqJ9U5AZtk=;
        b=ZLOWxmJAUkRmz99PrzURpBEZG+lRorwYA5sYvnetmeeN1sFTlllhPDkF2TgjrT4C9Y
         FKXvF++s6rqDamWJVc+hUwBmqyXJdixDZDBmDYOBiNLfCWtjid5w7ZXad2R9IPl3yoQv
         UZ8LPMKxOrjCtGugHE2/DiOitbVZGuDlJXLXMQSA2E7ZdQ8kSaxRXF9QLGKDtO5PW5uD
         sViX9x9hXd1RL7F3SSohUbDVzcdKP3dy9NIZFoNyVmoBs1esbq429SlnuznTo2ny1hbM
         y+G+jjQydPn06+CkhSQEHBmxvS/zzw5zd8SXVT92bY2/ODvu2Kb/iZU1qwLQXDmVQ3i/
         7Tbg==
X-Gm-Message-State: ALQs6tCVVGdu1AlXJ4nxg0LtTMGa4oxZmHc7dr79cfyhU1Nm/uSJpyrJ
        /uAyZImcBLypol4GbESI27HrDA==
X-Google-Smtp-Source: AB8JxZo/iF2TluKuYkUonVZTuj8KK1vsuQlQh5NEzjYDFJuMgtMDqt7xEqzAZUN/uAAbfdenw+qDAA==
X-Received: by 10.28.91.209 with SMTP id p200mr12754988wmb.11.1524616333311;
        Tue, 24 Apr 2018 17:32:13 -0700 (PDT)
Received: from jive (5E1BAE01.mobile.pool.telekom.hu. [94.27.174.1])
        by smtp.gmail.com with ESMTPSA id m6sm20149061wmb.9.2018.04.24.17.32.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 17:32:12 -0700 (PDT)
Date:   Wed, 25 Apr 2018 02:32:08 +0200
From:   Lev <leventelist@gmail.com>
To:     git@vger.kernel.org
Subject: git https and github
Message-ID: <20180425023208.5e76e93d@jive>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgbGlzdCwNCg0KDQpJJ20gc3RydWdnbGluZyB3aXRoIGdpdCBjb25uZWN0aW5nIHRvIEdpdGh1
Yi4NCg0KVGhlIHByb2JsZW0gbWlnaHQgYmUgU1NML1RMUyByZWxhdGVkLg0KDQpodHRwczovL2dp
dGh1YmVuZ2luZWVyaW5nLmNvbS9jcnlwdG8tcmVtb3ZhbC1ub3RpY2UvDQoNCkkgc3VzcGVjdCB0
aGF0IG15IHNldHVwIHN0aWxsIHVzZXMgdGxzdjEgb3IgdGxzdjEuMS4NCg0KSSd2ZSB0cmllZCB0
byBleHBsaWNpdGx5IHNldCBnaXQgdG8gdXNlIHRsc3YxLjIgaW4gbXkgLmdpdGNvbmZpZyBmaWxl
DQpsaWtlIHRoaXM6DQoNCltodHRwXQ0KCXNzbFZlcnNpb24gPSB0bHN2MS4yDQoNCkkndmUgdHJp
ZWQgdG8gcmUtY29tcGlsZSBnaXQgd2l0aCBPcGVuU1NMIGFuZCBHbnVUTFMuIEFsbCBnaXZlIHRo
ZQ0Kc2FtZSBlcnJvci4NCg0KZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9PbmlvbklvVC9z
b3VyY2UuZ2l0DQpDbG9uaW5nIGludG8gJ3NvdXJjZScuLi4NCiogQ291bGRuJ3QgZmluZCBob3N0
IGdpdGh1Yi5jb20gaW4gdGhlIC5uZXRyYyBmaWxlOyB1c2luZyBkZWZhdWx0cw0KKiAgIFRyeWlu
ZyAxOTIuMzAuMjUzLjExMi4uLg0KKiBUQ1BfTk9ERUxBWSBzZXQNCiogQ29ubmVjdGVkIHRvIGdp
dGh1Yi5jb20gKDE5Mi4zMC4yNTMuMTEyKSBwb3J0IDQ0MyAoIzApDQoqIEFMUE4sIG9mZmVyaW5n
IGh0dHAvMS4xDQoqIENpcGhlciBzZWxlY3Rpb246DQpBTEw6IUVYUE9SVDohRVhQT1JUNDA6IUVY
UE9SVDU2OiFhTlVMTDohTE9XOiFSQzQ6QFNUUkVOR1RIDQoqIHN1Y2Nlc3NmdWxseSBzZXQgY2Vy
dGlmaWNhdGUgdmVyaWZ5IGxvY2F0aW9uczoNCiogICBDQWZpbGU6IC9ldGMvc3NsL2NlcnRzL2Nh
LWNlcnRpZmljYXRlcy5jcnQNCiAgQ0FwYXRoOiAvZXRjL3NzbC9jZXJ0cw0KKiBlcnJvcjoxNDA5
NDQyRTpTU0wgcm91dGluZXM6c3NsM19yZWFkX2J5dGVzOnRsc3YxIGFsZXJ0IHByb3RvY29sDQp2
ZXJzaW9uDQoqIEN1cmxfaHR0cF9kb25lOiBjYWxsZWQgcHJlbWF0dXJlID09IDENCiogc3RvcHBl
ZCB0aGUgcGF1c2Ugc3RyZWFtIQ0KKiBDbG9zaW5nIGNvbm5lY3Rpb24gMA0KZmF0YWw6IHVuYWJs
ZSB0byBhY2Nlc3MgJ2h0dHBzOi8vZ2l0aHViLmNvbS9PbmlvbklvVC9zb3VyY2UuZ2l0Lyc6DQpl
cnJvcjoxNDA5NDQyRTpTU0wgcm91dGluZXM6c3NsM19yZWFkX2J5dGVzOnRsc3YxIGFsZXJ0IHBy
b3RvY29sDQp2ZXJzaW9uIGxldkBqaXZlOn4vZ2l0JCB1bnNldCBHSVRfU1NMX1ZFUlNJT04gbGV2
QGppdmU6fi9naXQkIGdpdCBjbG9uZQ0KaHR0cHM6Ly9naXRodWIuY29tL09uaW9uSW9UL3NvdXJj
ZS5naXQgQ2xvbmluZyBpbnRvICdzb3VyY2UnLi4uDQoqIENvdWxkbid0IGZpbmQgaG9zdCBnaXRo
dWIuY29tIGluIHRoZSAubmV0cmMgZmlsZTsgdXNpbmcgZGVmYXVsdHMNCiogICBUcnlpbmcgMTky
LjMwLjI1My4xMTIuLi4NCiogVENQX05PREVMQVkgc2V0DQoqIENvbm5lY3RlZCB0byBnaXRodWIu
Y29tICgxOTIuMzAuMjUzLjExMikgcG9ydCA0NDMgKCMwKQ0KKiBBTFBOLCBvZmZlcmluZyBodHRw
LzEuMQ0KKiBDaXBoZXIgc2VsZWN0aW9uOg0KQUxMOiFFWFBPUlQ6IUVYUE9SVDQwOiFFWFBPUlQ1
NjohYU5VTEw6IUxPVzohUkM0OkBTVFJFTkdUSA0KKiBzdWNjZXNzZnVsbHkgc2V0IGNlcnRpZmlj
YXRlIHZlcmlmeSBsb2NhdGlvbnM6DQoqICAgQ0FmaWxlOiAvZXRjL3NzbC9jZXJ0cy9jYS1jZXJ0
aWZpY2F0ZXMuY3J0DQogIENBcGF0aDogL2V0Yy9zc2wvY2VydHMNCiogZXJyb3I6MTQwOTQ0MkU6
U1NMIHJvdXRpbmVzOnNzbDNfcmVhZF9ieXRlczp0bHN2MSBhbGVydCBwcm90b2NvbA0KdmVyc2lv
bg0KKiBDdXJsX2h0dHBfZG9uZTogY2FsbGVkIHByZW1hdHVyZSA9PSAxDQoqIHN0b3BwZWQgdGhl
IHBhdXNlIHN0cmVhbSENCiogQ2xvc2luZyBjb25uZWN0aW9uIDANCmZhdGFsOiB1bmFibGUgdG8g
YWNjZXNzICdodHRwczovL2dpdGh1Yi5jb20vT25pb25Jb1Qvc291cmNlLmdpdC8nOg0KZXJyb3I6
MTQwOTQ0MkU6U1NMIHJvdXRpbmVzOnNzbDNfcmVhZF9ieXRlczp0bHN2MSBhbGVydCBwcm90b2Nv
bCB2ZXJzaW9uDQoNCg0KSSBjYW4gY29ubmVjdCB0byBvdGhlciBnaXQgc2VydmVycyB3aXRob3V0
IGFueSBlcnJvci4gVGhpcyBpcyBhIGRlYmlhbg0Kc3RhYmxlIHN5c3RlbSB3aXRoIHRoZSBmb2xs
b3dpbmcgY29tcG9uZW50czoNCg0KCWdpdCB2ZXJzaW9uIDIuMTEuMA0KDQoJbGliY3VybCA3LjUy
LjENCg0KCU9wZW5TU0wgMS4wLjJsDQoNCg0KSXMgdGhlcmUgYW55IHdheSB0byBrbm93IHdoYXQg
aXMgdGhlIGV4YWN0IHByb3RvY29sIHVzZWQ/IEFyZSB0aGVyZSBhbnkNCndvcmthcm91bmQsIGZp
eCBmb3IgdGhpcyBpc3N1ZT8NCg0KQW55IGhlbHAgd2VsY29tZS4gVGhhbmsgeW91LA0KTGV2ZW50
ZQ0KDQotLSANCkxldmVudGUgS292YWNzDQpTZW5pb3IgRWxlY3Ryb25pYyBFbmdpbmVlcg0KDQpX
OiBodHRwOi8vbGV2ZW50ZS5sb2dvbmV4LmV1DQo=
