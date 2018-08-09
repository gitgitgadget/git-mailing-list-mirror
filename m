Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2659E1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeHIPzL (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 11:55:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:46217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730090AbeHIPzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 11:55:11 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx5hl-1fz9tQ0MuH-016byb; Thu, 09
 Aug 2018 15:30:09 +0200
Date:   Thu, 9 Aug 2018 15:30:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase --exec: make it work with
 --rebase-merges
In-Reply-To: <3ccf2fcf-5d58-5d24-7e0b-d1d0e511feaa@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1808091529210.71@tvgsbejvaqbjf.bet>
References: <pull.13.git.gitgitgadget@gmail.com> <pull.13.v2.git.gitgitgadget@gmail.com> <7ca441a89674ee77cbbb3ec17f931aecba7bfa0d.1533549169.git.gitgitgadget@gmail.com> <f7da64c2-0477-07dd-35ef-7cfd16447bd5@talktalk.net> <nycvar.QRO.7.76.6.1808091039080.71@tvgsbejvaqbjf.bet>
 <3ccf2fcf-5d58-5d24-7e0b-d1d0e511feaa@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pYYoMMa+mfzBkpWLV9gpXVkX97mfVYIr2Vt0buSK6CFeiq3OJ6h
 Q1TT3laCunWE7H4Rps9xrWa6FBGLa1RRZ8mdgectI4MeUxJLxNw05/haNdBKyiXyqSpbEmi
 Wjs+WT+BHsghiaYXjDTCVOVYqC6HDBN3nB2e802J2pDCj2VB3qkoaXAsVi51GAKriby4xv3
 DjHXG1fbNfF5MJskH5L5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9H2ImAyDH9w=:wuz8E5utTUPCQW0jQBw1XA
 3tKy/eHvNy0v6OLf5ka0A4OazfuxKH4eqk53i0swXSTh1dt1AL1tEDn0fpaD+rVUp7VS/SdvW
 HHD5WXtVFSKoyszAb1DGAGVhp2HatMouV5h69+NdzwBqT8X65SlUuKa3V2A094jgcjsfYvVK5
 fiF+pCdIDAKM9FXr6oyWGn6/rFfgZRcsK7GqDjTfyqF1SJlFyDE4DSuVWBDGFoGbUitlb9iz0
 CTYNA25auZ8b/PWRTo+PV8aLjKRNnsY1FaglJCFsNboU0YN/Uc89E1rUXaeyCV0Rb1X+RgLYJ
 i4XsJTQiI8P/WJJMkqQjEvVcp4/E2cu9S8SwUIBSzLSOrpeJbXs+ZTHZtFE+uC/Pt0p9R6Lh6
 PDaH4yCURUDsazoVCJgRhs497cpXjYUS4juAJ+SQ2T62B6DriMyRQd3OZBVNAWQ7F3f7YuypG
 d2Z9aBCCQb1sPoVAr04a+8CdDbAw2CdUo5Nlq9UL67VLUBk9U2pCLXE9tY+bZaHp26T9u+CdF
 sUp+RXcq+iVYhsqtRiPpBLBXp6LVBGHneSrBN4MbUJFAH+6Uc7K1mjjb3TMxwPRFKfe3fRQQy
 WZtQ0Rg9U9SF/bWvsGvKp3UUBkj/zORRud1bDkqvPwGLsJIHQHSCU/jaO0tRWqngnCWBJL1k3
 ZNEYhSZ7rO9iDH4AInJ9D3hbGuHpOB7lk8k40fLcXxCLr9bhBD2iaDvbp3e6l6ox6cRD2J50D
 KzDL5jR4HqltBWrzkgSB6sstUTb+szd32s5ZP3pgi6CODsJdevhYU69pFzC+mKN0iG8kIJRSZ
 Lk/mRvH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 9 Aug 2018, Phillip Wood wrote:

> On 09/08/18 10:22, Johannes Schindelin wrote:
> > 
> > On Mon, 6 Aug 2018, Phillip Wood wrote:
> > 
> >> On 06/08/18 10:52, Johannes Schindelin via GitGitGadget wrote:
> >>>
> >>> +			else if (is_fixup(command)) {
> >>> +				insert = i + 1;
> >>> +				continue;
> >>> +			}
> >>> +			strbuf_insert(buf,
> >>> +				      todo_list.items[insert].offset_in_buf +
> >>> +				      offset, commands, commands_len);
> >>>   			offset += commands_len;
> >>> +			insert = -1;
> >>>   		}
> >>> -		first = 0;
> >>> +
> >>> +		if (command == TODO_PICK || command == TODO_MERGE)
> >>> +			insert = i + 1;
> >>>    }
> >>>   
> >>>   	/* append final <commands> */
> >>> -	strbuf_add(buf, commands, commands_len);
> >>> +	if (insert >= 0 || !offset)
> >>> +		strbuf_add(buf, commands, commands_len);
> >>
> >> Having read your other message about this patch I think if you wanted to fix
> >> the position of the final exec in the case where the todo list ends with a
> >> comment you could do something like
> >>
> >> 	if (insert >= 0)
> >> 		strbuf_insert(buf,
> >> 			      todo_list.items[insert].offset_in_buf +
> >> 			      offset, commands, commands_len);
> >> 	else
> >> 		strbuf_add(buf, commands, commands_len);
> > 
> > That does not really work, as `insert` can point *after* the last line, in
> > which case `todo_list.items[insert]` is undefined (and in the worst case,
> > causes a segmentation fault).
> 
> Ah, I'd missed that, does changing the conditions to
> if (insert >= 0 && insert < todo.list_nr) and
> else if (insert >=0 || !offset) work?

That's pretty exactly what I did ;-)

Ciao,
Dscho
