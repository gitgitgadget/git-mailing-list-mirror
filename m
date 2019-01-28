Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083FD1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 23:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfA1XIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 18:08:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:38069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1XIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 18:08:52 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb4vZ-1hTfR11xqj-00kdpb; Tue, 29
 Jan 2019 00:08:46 +0100
Date:   Tue, 29 Jan 2019 00:08:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Xenos <sxenos@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 5/8] evolve: Add the change-table structure
In-Reply-To: <nycvar.QRO.7.76.6.1901280858060.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1901290005390.41@tvgsbejvaqbjf.bet>
References: <20190127194415.171035-1-sxenos@google.com> <20190127194415.171035-5-sxenos@google.com> <nycvar.QRO.7.76.6.1901280858060.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YS99H1706MRenrOgngPcBxlGvrCsEFjzZ7GMTpErXHkCD3s46S/
 impEgeJIzymxLf10JO6XlzXH0Ge176tpA25EXqQuWl4bhapKBskx4IbJ2wI5INo+Az7ZuwX
 v6xwGQTmzCULxEmgSTlpSVovi5wYFrgWqwjhqmQ78Lhzc3p8i5fCquFIKz+ef73kB6XbCfi
 RFqcjQ4tDL5z+lV8VLmLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X2Xy3dZEZY0=:yradXNwQHPC8VJKqMIkByd
 JbtAROs2rPyet9I/NADSx4k98GE+Owt/YtrW20uVLqR9ysc0mUEQSFUw+BeZRI+4vHCUEtNwl
 TrHH1qOMOjBazVXoHhaRggP3JqtBgsqFak9LlP9J/ambxC4GHBAzjWpBZblzQXeWY/AFm7x2w
 XUVy+LS1uGLkLz4M+lyz2pRE1NLH/SYIHvILx64Jyv6yfCsrVZYYB80zpYMUsFi6x+kFPVZD0
 ILuXrgLP40hwE0gTw6Ydml6GwpkViycjSOZkY7Kn6oDJpWi2r0fRbQMFJJ3sdpaGyj87qqGBH
 Vu2so2jsOD1SMPV4qgBuF1YLyB3xzUE3lRKhhwNSWSAA3zu6BUT6MRpCKvBXJQf9iYobgcFc2
 rHWRyxLScWsf3GyR1NNM9NT0KGZjPFibaAnhNCzBGr1DfoAXMEsG5snBxujzjTe39hWbOzZfY
 9TJvuVdbtXG5mwX5JcPhtYQqxENY7fIxw2QL4UHbHCJOI75Kd1+n7UqOxMzgf1zLXnYsdA47C
 EkW54TUy8il/W5aewETa+jnZGQukiIrGt4jahtGB3/YcrbcX7VqkP8u/keAmF9b90A+9wrbT2
 hlE4Y2HNdQeE9CsCkQrKt/m00BAs8sSndBEi3Qpum2WYCkZQrRFwVmU2vOs9+GlrQmo6K42ni
 VyDwdCLB6nu0I6rntlVThPFOtb4rOZlKqHKgFwEUF1FZHpYr/RKJjidfBky+4pE3Zlt2bhkAE
 ycr+9GnhSETw/fIDWFcVovM/MaoOCOoCQq2V5WH1E2qS9tmYs82R+0Xww76tR79QB1NzeInRr
 ShK8GoDAWwvleFYkynmCaTVrZBr0ToTj2JuruBPlrI88dqm/UBODrJ4bU0fms0RpoVcWPkmk9
 LCBMgkIImCnbi0a2nzcN6XYeXn1Kqw3QXKfLYL0NBT962Mok0Kf/fgC0IQaEg3vnT0ONq7GYO
 FDitDAvlkLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Johannes Schindelin wrote:

> On Sun, 27 Jan 2019, sxenos@google.com wrote:
> 
> > +	new_item->util = (void*)index;
> 
> This is not good. You are using a `long` here. The 80s called and want
> their now-obsolete data types back.
> 
> If you want a data type that can take an integer but also a pointer, use
> `intptr_t` instead.
> 
> But even that is not good practice. What you really want here is to use a
> union of the data types that you want to store in that `util` field.
> 
> This is not merely academic, your code causes compile errors on Windows:
> 
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=400&view=logs&jobId=fd490c07-0b22-5182-fac9-6d67fe1e939b&taskId=ce91d5d6-0c55-50f5-8ab9-6695c03ab102&lineStart=430&lineEnd=440&colStart=1&colEnd=1

Since Stefan did not grace us with an answer, Junio, could I ask you to
squash this in (which is by no means a satisfactory fix, but it is a
stopgap to get `pu` building again)?

-- snipsnap --
diff --git a/change-table.c b/change-table.c
index 2e0d935de846..197ce2783532 100644
--- a/change-table.c
+++ b/change-table.c
@@ -103,7 +103,7 @@ void change_table_add(struct change_table *to_modify, const char *refname,
 	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
 
 	new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
-	new_item->util = (void*)index;
+	new_item->util = (void *)(intptr_t)index;
 	// Use pointers to the copy of the string we're retaining locally
 	refname = new_item->string;
 
@@ -201,6 +201,6 @@ struct change_head* get_change_head(struct change_table *heads,
 		return NULL;
 	}
 
-	index = (long)item->util;
+	index = (long)(intptr_t)item->util;
 	return &(heads->heads.array[index]);
 }

