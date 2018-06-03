Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C591F403
	for <e@80x24.org>; Sun,  3 Jun 2018 15:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeFCP2j (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 11:28:39 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:52356 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeFCP2j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 11:28:39 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id PUvsfunPbpXFjPUvsfzHK2; Sun, 03 Jun 2018 16:28:37 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ynD9KIp7XrbHlcvsphUA:9
 a=3JSj22BRnowZ24Bh:21 a=_-3QwcShEGBhcUli:21 a=wPNLvfGTeEIA:10
 a=MY9urf3tlLUA:10
Message-ID: <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE> <87y3hlecod.fsf@evledraar.gmail.com> <20180603092736.GA5510@helen.PLASMA.Xg8.DE> <87vab087y2.fsf@evledraar.gmail.com> <20180603112557.GA6564@helen.PLASMA.Xg8.DE> <87tvqk81qp.fsf@evledraar.gmail.com> <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
Subject: Re: GDPR compliance best practices?
Date:   Sun, 3 Jun 2018 16:28:31 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180603-2, 03/06/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfCf+wOkTiN+VIqmKOGyRZZ5QgiFOzcrQ35ijxI2TkLckKC8fsFxnUDT+NLmdZSOkKRTfTTokWK1o7S1ziKzYE9j1UKEPff5sN+aIHyxFXsLjEmfodow6
 LUy8vh6Wet7pp5e6U56G39Xa6rQMqAp7vWK1ybXXtCE42DcINrAYXikkQo5Jq5L3JeW3aAHVs1JtFN0n91vXzpzKO+bLClxvG8ITH57sRnubRj3aFjQ0vv1p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>
> On Sun, Jun 03, 2018 at 02:59:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> I'm not trying to be selfish, I'm just trying to counter your literal
>> reading of the law with a comment of "it'll depend".
>>
>> Just like there's a law against public urination in many places, but
>> this is applied very differently to someone taking a piss in front of
>> parliament v.s. someone taking a piss in the forest on a hike, even
>> though the law itself usually makes no distinction about the two.
>
> We have huge companies using git now. This is not the tool used by a
> few kernel hackers anymore.
>
>> In this example once you'd delete the UUID ref you don't have the UUID
>> -> author mapping anymore (and b.t.w. that could be a many to one
>> mapping).
>
> It is not relevant whether you have that mapping or not, it is enough
> that with additional information you could obtain it. For example, say,
> you have 5000 commits with the same UUID. Now your delete the mapping.
> But your friend still has it on his local copy. Now your friendly
> merely needs to tell you who is behind that UUID and instantly you can
> associate all 5000 commits with that person again.
>
> The GDPR is very explict about this, see recital 26. It says that
> pseudonymization is not enough, you need anonymization if you want to
> be free from regulation.
>
> In addition, and in contrast to my proposal, your solution doesn't
> allow verification of the author field.
>
>> I think again that this is taking too much of a literalist view. The
>> intent of that policy is to ensure that companies like Google can't just
>> close down their EU offices weasel out of compliance be saying "we're
>> just doing business from the US, it doesn't apply to us".
>>
>> It will not be used against anyone who's taking every reasonable
>> precaution from doing business with EU customers.
>
> I think you are underestimating the political intention behind the
> GDPR. It has kind of an imperialist goal, to set international
> standards, to enforce them against foreign companies and to pressure
> other nations to establish the same standards.
>
> If I would read the GPDR in a literal sense, I would in fact come to
> the same conclusion as you: It's about companies doing substantial
> business in the EU. But the GDPR is carefully constructed in such a way
> that it is hard not to be affected by the GDPR in one way or another,
> and the obvious way to cope with that risk is to more or less obey the
> GDPR rules even if one does not have substantial business interests in
> the EU.
>
>> What do you imagine that this is going to be like? That some EU citizen
>> is going to walk into a small business in South America one day, which
>> somehow is violating the GPDR, and when that business owner goes on
>> holiday to the EU they're going to get detained? Not even the US policy
>> against Cuba is anywhere remotely close to that.
>
> Well not if he's locally interacting with that business, a situation
> which I am sure is not regulated by the GDPR.
>
> However, if a large US website accepts users from the EU and uses the
> data gathered in conflict with the GDPR, perhaps selling it for use in
> political campaigns, and it gets several fines for this by EU
> authorities but ignores them and doesn't pay them, and the CEO one day
> takes a flight to Frankfurt to continue by train to Switzerland to get
> some cash from his bank account, then he will most likely not reach
> Swiss territory.
>

--
Having been through corporate training and read up a number of the
conflicting views in the press, one of the issues is that there are two
viewpoints, one from each side of the fence.

From a corporate/organisation viewpoint, it is best if every case of holding
user information is for a legitimate purpose, which then means the company
has 'protection' from requests for removal because the data *is* held
legally/legitimately (which includes acting as evidence).

In most Git cases that legal/legitimate purpose is the copyright licence,
and/or corporate employment. That is, Jane wrote it, hence X has a legal
rights of use, and we need to have a record of that (Jane wrote it) as
evidence of that (I'm X, I can use it) right. That would mean that Jane
cannot just ask to have that record removed and expect it to be removed.

From a personal view, many folk want it to be that corporates (and open
source organisations) should hold no personal information with having
explicit permission that can then be withdrawn, with deletion to follow.
However that 'legal' clause does [generally] win.

In the git.git case (and linux.git) there is the DCO (to back up the GLP2)
as an explicit requirement/certification that puts the information into the
legal evidence category. IIUC almost all copyright ends up with a similar
evidentail trail for the meta data.


The more likely problem is if the content of the repo, rather than the meta
data, is subject to GDPR, and that could easily ruin any storage method.
Being able to mark an object as <Lost/Deleted> would help here(*).

Also remember that most EU legislation is 'intent' based, rather than
'letter of', for the style of legal arguments (which is where some of the UK
Brexit misunderstandings come from), so it is more than possible to get into
the situation where an action is both mandated and illegal at the same time,
so plent of snake oil salesman continue to sell magic fixes according to the
customers local biases.

I do not believe Git has anything to worry about that wasn't already an
issue.
--
Philip
(*) the "mark an object as <Lost/Deleted>" is something I'd like for doing
Narrow clones, it's almost/exactly like the missing sub-module revision
"problem".

